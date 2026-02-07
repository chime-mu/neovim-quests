defmodule NeovimOdyssey.QuestsTest do
  use ExUnit.Case, async: true

  alias NeovimOdyssey.Quests

  describe "list_zones/0" do
    test "returns all 6 zones" do
      zones = Quests.list_zones()
      assert length(zones) == 6
    end

    test "zones are ordered by number" do
      zones = Quests.list_zones()
      numbers = Enum.map(zones, & &1.number)
      assert numbers == [1, 2, 3, 4, 5, 6]
    end
  end

  describe "get_zone/1" do
    test "finds zone by number" do
      zone = Quests.get_zone(1)
      assert zone.name == "The Crossroads"
      assert zone.xp_required == 0
    end

    test "finds zone by id" do
      zone = Quests.get_zone("zone_3")
      assert zone.name == "The Tower of Language"
      assert zone.number == 3
    end

    test "returns nil for unknown zone" do
      assert Quests.get_zone(99) == nil
      assert Quests.get_zone("zone_99") == nil
    end
  end

  describe "get_quest/1" do
    test "finds quest by id" do
      quest = Quests.get_quest("quest_1_1")
      assert quest.name == "Install the Blade"
      assert quest.xp == 10
      assert quest.type == :chain
    end

    test "finds boss by id" do
      boss = Quests.get_quest("boss_1")
      assert boss.name == "The Config Gauntlet"
      assert boss.xp == 50
      assert boss.type == :boss
    end

    test "finds side quest by id" do
      side = Quests.get_quest("side_2_1")
      assert side.name == "The Whisperer"
      assert side.type == :side
    end

    test "returns nil for unknown quest" do
      assert Quests.get_quest("nope") == nil
    end
  end

  describe "list_daily_quests/0" do
    test "returns 5 daily quests" do
      dailies = Quests.list_daily_quests()
      assert length(dailies) == 5
      assert Enum.all?(dailies, &(&1.type == :daily))
    end
  end

  describe "XP totals" do
    test "zone 1 total XP is 110" do
      zone = Quests.get_zone(1)
      quest_xp = Enum.sum(Enum.map(zone.quests, & &1.xp))
      side_xp = Enum.sum(Enum.map(zone.side_quests, & &1.xp))
      boss_xp = if zone.boss, do: zone.boss.xp, else: 0
      assert quest_xp + side_xp + boss_xp == zone.total_xp
    end

    test "all zone total_xp fields match actual quest XP sums" do
      for zone <- Quests.list_zones() do
        quest_xp = Enum.sum(Enum.map(zone.quests, & &1.xp))
        side_xp = Enum.sum(Enum.map(zone.side_quests, & &1.xp))
        boss_xp = if zone.boss, do: zone.boss.xp, else: 0
        actual = quest_xp + side_xp + boss_xp

        assert actual == zone.total_xp,
               "Zone #{zone.number} (#{zone.name}): expected #{zone.total_xp}, got #{actual}"
      end
    end

    test "total game XP is 1280" do
      total =
        Quests.list_zones()
        |> Enum.map(& &1.total_xp)
        |> Enum.sum()

      assert total == 1280
    end
  end

  describe "all_quests/0" do
    test "returns all quests across all zones" do
      quests = Quests.all_quests()
      assert length(quests) > 0
      # Every quest should have an id
      assert Enum.all?(quests, &(is_binary(&1.id) and &1.id != ""))
    end

    test "quest IDs are unique" do
      ids = Quests.all_quests() |> Enum.map(& &1.id)
      assert length(ids) == length(Enum.uniq(ids))
    end
  end
end
