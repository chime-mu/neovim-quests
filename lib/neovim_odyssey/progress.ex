defmodule NeovimOdyssey.Progress do
  @moduledoc false

  import Ecto.Query
  alias NeovimOdyssey.Repo
  alias NeovimOdyssey.Progress.{CompletedQuest, DailyQuestLog, PlayerStats}
  alias NeovimOdyssey.Quests

  @level_thresholds [{1, 0}, {5, 200}, {10, 500}, {15, 900}, {20, 1400}, {25, 2000}]
  @zone_thresholds %{1 => 0, 2 => 100, 3 => 300, 4 => 550, 5 => 800, 6 => 1100}

  # --- XP ---

  def total_xp do
    quest_xp =
      Repo.one(from c in CompletedQuest, select: coalesce(sum(c.xp_earned), 0))

    daily_xp =
      Repo.one(from d in DailyQuestLog, select: coalesce(sum(d.xp_earned), 0))

    quest_xp + daily_xp
  end

  # --- Levels ---

  def current_level(xp) do
    @level_thresholds
    |> Enum.reverse()
    |> Enum.reduce_while(1, fn {level, threshold}, _acc ->
      if xp >= threshold do
        {:halt, interpolate_level(xp, level, threshold)}
      else
        {:cont, 1}
      end
    end)
  end

  defp interpolate_level(xp, max_level, _threshold) when max_level == 25 do
    # Cap at 25
    min(25, base_interpolate(xp, max_level))
  end

  defp interpolate_level(xp, base_level, base_threshold) do
    {next_level, next_threshold} =
      @level_thresholds
      |> Enum.find(fn {l, _} -> l > base_level end) ||
        {25, 2000}

    level_span = next_level - base_level
    xp_span = next_threshold - base_threshold
    xp_into = xp - base_threshold

    if xp_span > 0 do
      base_level + trunc(xp_into / xp_span * level_span)
    else
      base_level
    end
  end

  defp base_interpolate(xp, _max_level) do
    # For level 25 bracket, just return 25 if at or above 2000
    if xp >= 2000, do: 25, else: 24
  end

  def level_title(level) do
    cond do
      level < 5 -> "Greenhorn"
      level < 10 -> "Apprentice"
      level < 15 -> "Journeyman"
      level < 20 -> "Expert"
      level < 25 -> "Master"
      true -> "Grandmaster"
    end
  end

  def xp_for_next_level(xp) do
    {current_base, current_threshold} =
      @level_thresholds
      |> Enum.reverse()
      |> Enum.find(fn {_l, t} -> xp >= t end) ||
        {1, 0}

    {_next_level, next_threshold} =
      @level_thresholds
      |> Enum.find(fn {l, _} -> l > current_base end) ||
        {25, 2000}

    current_lvl = current_level(xp)

    if current_lvl >= 25 do
      %{
        current_level: 25,
        current_xp: xp,
        xp_into_level: xp - current_threshold,
        xp_needed: 0,
        xp_for_level: 0,
        progress: 1.0
      }
    else
      xp_span = next_threshold - current_threshold
      xp_into = xp - current_threshold

      %{
        current_level: current_lvl,
        current_xp: xp,
        xp_into_level: xp_into,
        xp_needed: next_threshold - xp,
        xp_for_level: xp_span,
        progress: if(xp_span > 0, do: xp_into / xp_span, else: 1.0)
      }
    end
  end

  # --- Quest Completion ---

  def complete_quest(quest_id) do
    quest = Quests.get_quest(quest_id)

    cond do
      is_nil(quest) ->
        {:error, :quest_not_found}

      quest_completed?(quest_id) ->
        {:error, :already_completed}

      not zone_unlocked_for_quest?(quest) ->
        {:error, :zone_locked}

      true ->
        old_xp = total_xp()
        old_level = current_level(old_xp)

        result =
          %CompletedQuest{}
          |> CompletedQuest.changeset(%{
            quest_id: quest_id,
            xp_earned: quest.xp,
            completed_at: DateTime.utc_now() |> DateTime.truncate(:second)
          })
          |> Repo.insert()

        case result do
          {:ok, record} ->
            new_xp = old_xp + quest.xp
            new_level = current_level(new_xp)
            leveled_up = new_level > old_level

            {:ok, record,
             %{
               xp_gained: quest.xp,
               new_total_xp: new_xp,
               new_level: new_level,
               leveled_up: leveled_up,
               old_level: old_level
             }}

          {:error, changeset} ->
            {:error, changeset}
        end
    end
  end

  def complete_daily_quest(quest_id) do
    quest = Enum.find(Quests.list_daily_quests(), &(&1.id == quest_id))
    today = Date.utc_today()

    cond do
      is_nil(quest) ->
        {:error, :quest_not_found}

      daily_quest_done_today?(quest_id) ->
        {:error, :already_done_today}

      true ->
        old_xp = total_xp()
        old_level = current_level(old_xp)

        result =
          %DailyQuestLog{}
          |> DailyQuestLog.changeset(%{
            quest_id: quest_id,
            xp_earned: quest.xp,
            completed_date: today
          })
          |> Repo.insert()

        case result do
          {:ok, record} ->
            new_xp = old_xp + quest.xp
            new_level = current_level(new_xp)

            {:ok, record,
             %{
               xp_gained: quest.xp,
               new_total_xp: new_xp,
               new_level: new_level,
               leveled_up: new_level > old_level,
               old_level: old_level
             }}

          {:error, changeset} ->
            {:error, changeset}
        end
    end
  end

  # --- Status Queries ---

  def quest_completed?(quest_id) do
    Repo.exists?(from c in CompletedQuest, where: c.quest_id == ^quest_id)
  end

  def daily_quest_done_today?(quest_id) do
    today = Date.utc_today()
    Repo.exists?(from d in DailyQuestLog, where: d.quest_id == ^quest_id and d.completed_date == ^today)
  end

  def zone_unlocked?(zone_number) when is_integer(zone_number) do
    threshold = Map.get(@zone_thresholds, zone_number, 999_999)
    total_xp() >= threshold
  end

  def zone_unlocked?(zone_id) when is_binary(zone_id) do
    case Quests.get_zone(zone_id) do
      nil -> false
      zone -> zone_unlocked?(zone.number)
    end
  end

  def zone_completion(zone_id) do
    zone = Quests.get_zone(zone_id)
    if is_nil(zone), do: raise("Unknown zone: #{zone_id}")

    all_quest_ids =
      (zone.quests ++ zone.side_quests ++ if(zone.boss, do: [zone.boss], else: []))
      |> Enum.map(& &1.id)

    completed_count =
      Repo.one(
        from c in CompletedQuest,
          where: c.quest_id in ^all_quest_ids,
          select: count()
      )

    total = length(all_quest_ids)
    xp_earned = Repo.one(
      from c in CompletedQuest,
        where: c.quest_id in ^all_quest_ids,
        select: coalesce(sum(c.xp_earned), 0)
    )

    %{
      completed: completed_count,
      total: total,
      xp_earned: xp_earned,
      total_xp: zone.total_xp,
      progress: if(total > 0, do: completed_count / total, else: 0.0)
    }
  end

  def completed_quest_ids do
    Repo.all(from c in CompletedQuest, select: c.quest_id)
  end

  def reset_progress! do
    Repo.delete_all(CompletedQuest)
    Repo.delete_all(DailyQuestLog)
    :ok
  end

  # --- Helpers ---

  defp zone_unlocked_for_quest?(quest) do
    case quest.zone_id do
      nil -> true
      zone_id -> zone_unlocked?(zone_id)
    end
  end

  # --- HP System ---

  @hp_regen_per_hour 5
  @hp_daily_restore 10
  @boss_hp_cost 25

  def get_stats do
    stats = Repo.one(from(s in PlayerStats, limit: 1)) || create_initial_stats()
    apply_natural_regen(stats)
  end

  def get_hp, do: get_stats().hp

  defp create_initial_stats do
    %PlayerStats{}
    |> PlayerStats.changeset(%{hp: 100, max_hp: 100, last_hp_regen_at: DateTime.utc_now()})
    |> Repo.insert!()
  end

  defp apply_natural_regen(%PlayerStats{hp: hp, max_hp: max_hp} = stats) when hp >= max_hp do
    stats
  end

  defp apply_natural_regen(%PlayerStats{last_hp_regen_at: nil} = stats) do
    stats
    |> PlayerStats.changeset(%{last_hp_regen_at: DateTime.utc_now()})
    |> Repo.update!()
  end

  defp apply_natural_regen(%PlayerStats{hp: hp, max_hp: max_hp, last_hp_regen_at: last_regen} = stats) do
    now = DateTime.utc_now()
    hours_elapsed = DateTime.diff(now, last_regen, :second) / 3600.0
    regen_amount = trunc(hours_elapsed * @hp_regen_per_hour)

    if regen_amount > 0 do
      new_hp = min(hp + regen_amount, max_hp)

      stats
      |> PlayerStats.changeset(%{hp: new_hp, last_hp_regen_at: now})
      |> Repo.update!()
    else
      stats
    end
  end

  def lose_hp(amount \\ @boss_hp_cost) do
    stats = get_stats()
    new_hp = max(stats.hp - amount, 0)

    stats
    |> PlayerStats.changeset(%{hp: new_hp, last_hp_regen_at: DateTime.utc_now()})
    |> Repo.update!()
  end

  def restore_hp(amount \\ @hp_daily_restore) do
    stats = get_stats()
    new_hp = min(stats.hp + amount, stats.max_hp)

    stats
    |> PlayerStats.changeset(%{hp: new_hp})
    |> Repo.update!()
  end

  def can_attempt_boss?, do: get_stats().hp > 0

  def record_boss_attempt(_quest_id, passed?) do
    stats = get_stats()
    new_attempts = stats.boss_attempts + 1

    attrs = %{boss_attempts: new_attempts}
    attrs = if not passed?, do: Map.put(attrs, :hp, max(stats.hp - @boss_hp_cost, 0)), else: attrs

    stats
    |> PlayerStats.changeset(attrs)
    |> Repo.update!()
  end
end
