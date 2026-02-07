defmodule NeovimOdyssey.Repo.Migrations.CreateDailyQuestLogs do
  use Ecto.Migration

  def change do
    create table(:daily_quest_logs) do
      add :quest_id, :string, null: false
      add :xp_earned, :integer, null: false
      add :completed_date, :date, null: false
    end

    create unique_index(:daily_quest_logs, [:quest_id, :completed_date])
  end
end
