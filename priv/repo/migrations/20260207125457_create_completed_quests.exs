defmodule NeovimOdyssey.Repo.Migrations.CreateCompletedQuests do
  use Ecto.Migration

  def change do
    create table(:completed_quests) do
      add :quest_id, :string, null: false
      add :xp_earned, :integer, null: false
      add :completed_at, :utc_datetime, null: false
    end

    create unique_index(:completed_quests, [:quest_id])
  end
end
