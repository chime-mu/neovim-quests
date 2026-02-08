defmodule NeovimOdyssey.Repo.Migrations.AddVerificationFields do
  use Ecto.Migration

  def change do
    alter table(:completed_quests) do
      add :verified_by, :string, default: "self_attest"
      add :verification_data, :text
    end
  end
end
