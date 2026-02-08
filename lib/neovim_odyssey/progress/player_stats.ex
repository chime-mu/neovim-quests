defmodule NeovimOdyssey.Progress.PlayerStats do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_stats" do
    field :hp, :integer, default: 100
    field :max_hp, :integer, default: 100
    field :last_hp_regen_at, :utc_datetime
    field :boss_attempts, :integer, default: 0
    timestamps()
  end

  def changeset(stats, attrs) do
    stats
    |> cast(attrs, [:hp, :max_hp, :last_hp_regen_at, :boss_attempts])
    |> validate_number(:hp, greater_than_or_equal_to: 0)
    |> validate_number(:max_hp, greater_than: 0)
  end
end
