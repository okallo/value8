defmodule EmailsApp.Repo.Migrations.CreateGroupUser do
  use Ecto.Migration

  def change do
    create table(:group_user) do
      add :user_id, references(:users, on_delete: :nothing)
      add :group_id, references(:group, on_delete: :nothing)

      timestamps()
    end

    create index(:group_user, [:user_id])
    create index(:group_user, [:group_id])
  end
end
