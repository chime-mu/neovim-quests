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

  def ship_exterior, do: "/images/ship-exterior.png"
end
