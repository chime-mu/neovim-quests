defmodule NeovimOdyssey.Quests.Quest do
  @moduledoc false

  defstruct [
    :id,
    :zone_id,
    :number,
    :name,
    :xp,
    :description,
    :objectives,
    :turn_in,
    :type,
    :npc_greeting,
    :npc_confirmation
  ]

  @type quest_type :: :chain | :side | :boss | :daily

  @type t :: %__MODULE__{
          id: String.t(),
          zone_id: String.t() | nil,
          number: String.t(),
          name: String.t(),
          xp: integer(),
          description: String.t(),
          objectives: [String.t()],
          turn_in: String.t(),
          type: quest_type(),
          npc_greeting: String.t() | nil,
          npc_confirmation: String.t() | nil
        }
end
