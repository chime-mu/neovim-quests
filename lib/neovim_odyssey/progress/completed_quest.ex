defmodule NeovimOdyssey.Progress.CompletedQuest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "completed_quests" do
    field :quest_id, :string
    field :xp_earned, :integer
    field :completed_at, :utc_datetime
  end

  def changeset(completed_quest, attrs) do
    completed_quest
    |> cast(attrs, [:quest_id, :xp_earned, :completed_at])
    |> validate_required([:quest_id, :xp_earned, :completed_at])
    |> unique_constraint(:quest_id)
  end
end
