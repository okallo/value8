defmodule EmailsApp.Repo.Migrations.CreateGroupUser do
  use Ecto.Migration

  def change do
    create table(:group_user) do
      add :group_id, references(:group, on_delete: :nothing)
      add :user_id, references(:contacts, on_delete: :nothing)

      timestamps()
    end

    create index(:group_user, [:creadted_by])
    create index(:group_user, [:group_id])
  end
end
