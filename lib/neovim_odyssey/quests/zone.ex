defmodule NeovimOdyssey.Quests.Zone do
  @moduledoc false

  defstruct [
    :id,
    :name,
    :number,
    :tagline,
    :theme,
    :xp_required,
    :icon,
    :total_xp,
    :npc,
    :npc_title,
    :zone_intro,
    quests: [],
    side_quests: [],
    boss: nil
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          number: integer(),
          tagline: String.t(),
          theme: String.t(),
          xp_required: integer(),
          icon: String.t(),
          total_xp: integer(),
          npc: String.t() | nil,
          npc_title: String.t() | nil,
          zone_intro: String.t() | nil,
          quests: [NeovimOdyssey.Quests.Quest.t()],
          side_quests: [NeovimOdyssey.Quests.Quest.t()],
          boss: NeovimOdyssey.Quests.Quest.t() | nil
        }
end
