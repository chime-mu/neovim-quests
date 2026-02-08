defmodule NeovimOdyssey.Repo.Migrations.CreatePlayerStats do
  use Ecto.Migration

  def change do
    create table(:player_stats) do
      add :hp, :integer, default: 100, null: false
      add :max_hp, :integer, default: 100, null: false
      add :last_hp_regen_at, :utc_datetime
      add :boss_attempts, :integer, default: 0, null: false
      timestamps()
    end
  end
end
