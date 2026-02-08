defmodule NeovimOdysseyWeb.Helpers.Images do
  @zone_slugs %{
    1 => "bridge",
    2 => "module-bay",
    3 => "analysis-deck",
    4 => "nav-array",
    5 => "engine-room",
    6 => "command-chair"
  }

  def zone_image(zone_number) do
    slug = Map.get(@zone_slugs, zone_number, "bridge")
    "/images/zones/zone-#{zone_number}-#{slug}.png"
  end

  def zone_thumbnail(zone_number), do: zone_image(zone_number)

  @npc_portraits %{
    "Chief Torres" => "torres",
    "Ren" => "ren",
    "SOLEN" => "solen",
    "Jin" => "jin",
    "Vasquez" => "vasquez"
  }

  def npc_portrait(npc_name) do
    slug = Map.get(@npc_portraits, npc_name, npc_name |> String.downcase() |> String.split() |> List.last())
    "/images/npcs/npc-#{slug}.png"
  end

  def quest_image(quest_id) do
    path = "/images/quests/quest-#{quest_id}.png"

    if File.exists?(Path.join(:code.priv_dir(:neovim_odyssey), "static#{path}")) do
      path
    else
      # Fallback to zone image — extract zone number from quest_id
      case quest_id do
        "quest_" <> rest -> zone_image(String.to_integer(String.first(rest)))
        "boss_" <> rest -> zone_image(String.to_integer(String.first(rest)))
        "side_" <> rest -> zone_image(String.to_integer(String.first(rest)))
        _ -> ship_exterior()
      end
    end
  end

  def ship_exterior, do: "/images/ship-exterior.png"
end
