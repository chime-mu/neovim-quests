defmodule NeovimOdyssey.Quests do
  @moduledoc false

  alias NeovimOdyssey.Quests.Data

  def list_zones, do: Data.zones()

  def get_zone(zone_number) when is_integer(zone_number) do
    Enum.find(Data.zones(), &(&1.number == zone_number))
  end

  def get_zone(zone_id) when is_binary(zone_id) do
    Enum.find(Data.zones(), &(&1.id == zone_id))
  end

  def get_quest(quest_id) do
    all_quests()
    |> Enum.find(&(&1.id == quest_id))
  end

  def list_daily_quests, do: Data.daily_quests()

  def all_quests do
    Data.zones()
    |> Enum.flat_map(fn zone ->
      zone.quests ++ zone.side_quests ++ [zone.boss]
    end)
    |> Enum.reject(&is_nil/1)
  end

  def quests_for_zone(zone_id) do
    case get_zone(zone_id) do
      nil -> []
      zone -> zone.quests ++ zone.side_quests ++ if(zone.boss, do: [zone.boss], else: [])
    end
  end
end
