defmodule NeovimOdyssey.ProgressTest do
  use NeovimOdyssey.DataCase, async: true

  alias NeovimOdyssey.Progress

  setup do
    Progress.reset_progress!()
    :ok
  end

  describe "total_xp/0" do
    test "starts at 0" do
      assert Progress.total_xp() == 0
    end

    test "increases after completing a quest" do
      {:ok, _, _} = Progress.complete_quest("quest_1_1")
      assert Progress.total_xp() == 10
    end
  end

  describe "current_level/1" do
    test "level 1 at 0 XP" do
      assert Progress.current_level(0) == 1
    end

    test "level 5 at 200 XP" do
      assert Progress.current_level(200) == 5
    end

    test "level 10 at 500 XP" do
      assert Progress.current_level(500) == 10
    end

    test "level 15 at 900 XP" do
      assert Progress.current_level(900) == 15
    end

    test "level 20 at 1400 XP" do
      assert Progress.current_level(1400) == 20
    end

    test "level 25 at 2000 XP" do
      assert Progress.current_level(2000) == 25
    end

    test "interpolates between thresholds" do
      # Between 0 and 200 XP (levels 1-5)
      level = Progress.current_level(100)
      assert level >= 1 and level <= 5
    end
  end

  describe "level_title/1" do
    test "returns correct titles" do
      assert Progress.level_title(1) == "Greenhorn"
      assert Progress.level_title(4) == "Greenhorn"
      assert Progress.level_title(5) == "Apprentice"
      assert Progress.level_title(9) == "Apprentice"
      assert Progress.level_title(10) == "Journeyman"
      assert Progress.level_title(14) == "Journeyman"
      assert Progress.level_title(15) == "Expert"
      assert Progress.level_title(19) == "Expert"
      assert Progress.level_title(20) == "Master"
      assert Progress.level_title(24) == "Master"
      assert Progress.level_title(25) == "Grandmaster"
    end
  end

  describe "xp_for_next_level/1" do
    test "returns progress info" do
      info = Progress.xp_for_next_level(0)
      assert info.current_level == 1
      assert info.current_xp == 0
      assert info.progress >= 0.0
    end

    test "at max level, progress is 1.0" do
      info = Progress.xp_for_next_level(2000)
      assert info.current_level == 25
      assert info.progress == 1.0
    end
  end

  describe "zone_unlocked?/1" do
    test "zone 1 always unlocked" do
      assert Progress.zone_unlocked?(1) == true
    end

    test "zone 2 locked at 0 XP" do
      assert Progress.zone_unlocked?(2) == false
    end

    test "zone 2 unlocks at 100 XP" do
      # Complete quests worth >= 100 XP
      {:ok, _, _} = Progress.complete_quest("quest_1_1")  # 10
      {:ok, _, _} = Progress.complete_quest("quest_1_2")  # 10
      {:ok, _, _} = Progress.complete_quest("quest_1_3")  # 20
      {:ok, _, _} = Progress.complete_quest("quest_1_4")  # 20
      {:ok, _, _} = Progress.complete_quest("boss_1")     # 50
      # Total: 110 XP
      assert Progress.zone_unlocked?(2) == true
    end

    test "zone unlocked with string id" do
      assert Progress.zone_unlocked?("zone_1") == true
      assert Progress.zone_unlocked?("zone_2") == false
    end
  end

  describe "complete_quest/1" do
    test "completes a quest successfully" do
      assert {:ok, _, result} = Progress.complete_quest("quest_1_1")
      assert result.xp_gained == 10
      assert result.new_total_xp == 10
    end

    test "prevents duplicate completion" do
      {:ok, _, _} = Progress.complete_quest("quest_1_1")
      assert {:error, :already_completed} = Progress.complete_quest("quest_1_1")
    end

    test "prevents completing quest in locked zone" do
      assert {:error, :zone_locked} = Progress.complete_quest("quest_2_1")
    end

    test "returns error for unknown quest" do
      assert {:error, :quest_not_found} = Progress.complete_quest("nope")
    end

    test "detects level ups" do
      # quest_1_1 (10) + quest_1_2 (10) + quest_1_3 (20) + quest_1_4 (20) + boss_1 (50) = 110
      {:ok, _, _} = Progress.complete_quest("quest_1_1")
      {:ok, _, _} = Progress.complete_quest("quest_1_2")
      {:ok, _, _} = Progress.complete_quest("quest_1_3")
      {:ok, _, _} = Progress.complete_quest("quest_1_4")
      {:ok, _, result} = Progress.complete_quest("boss_1")
      # Going from 60 XP to 110 XP should level up
      assert result.new_level > result.old_level or result.leveled_up
    end
  end

  describe "complete_daily_quest/1" do
    test "completes a daily quest" do
      assert {:ok, _, result} = Progress.complete_daily_quest("daily_1")
      assert result.xp_gained == 5
    end

    test "prevents completing same daily twice in one day" do
      {:ok, _, _} = Progress.complete_daily_quest("daily_1")
      assert {:error, :already_done_today} = Progress.complete_daily_quest("daily_1")
    end

    test "returns error for unknown daily" do
      assert {:error, :quest_not_found} = Progress.complete_daily_quest("nope")
    end
  end

  describe "quest_completed?/1" do
    test "false for uncompleted quest" do
      refute Progress.quest_completed?("quest_1_1")
    end

    test "true for completed quest" do
      {:ok, _, _} = Progress.complete_quest("quest_1_1")
      assert Progress.quest_completed?("quest_1_1")
    end
  end

  describe "zone_completion/1" do
    test "returns correct zone stats" do
      completion = Progress.zone_completion("zone_1")
      assert completion.completed == 0
      assert completion.total == 5  # 4 chain + 0 side + 1 boss
      assert completion.xp_earned == 0
      assert completion.total_xp == 110
    end

    test "updates after completing quests" do
      {:ok, _, _} = Progress.complete_quest("quest_1_1")
      completion = Progress.zone_completion("zone_1")
      assert completion.completed == 1
      assert completion.xp_earned == 10
    end
  end

  describe "reset_progress!/0" do
    test "clears all progress" do
      {:ok, _, _} = Progress.complete_quest("quest_1_1")
      {:ok, _, _} = Progress.complete_daily_quest("daily_1")
      assert Progress.total_xp() > 0

      Progress.reset_progress!()
      assert Progress.total_xp() == 0
      refute Progress.quest_completed?("quest_1_1")
    end
  end
end
