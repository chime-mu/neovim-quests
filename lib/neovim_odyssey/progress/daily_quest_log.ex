defmodule NeovimOdyssey.Progress.DailyQuestLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_quest_logs" do
    field :quest_id, :string
    field :xp_earned, :integer
    field :completed_date, :date
  end

  def changeset(log, attrs) do
    log
    |> cast(attrs, [:quest_id, :xp_earned, :completed_date])
    |> validate_required([:quest_id, :xp_earned, :completed_date])
    |> unique_constraint([:quest_id, :completed_date])
  end
end
