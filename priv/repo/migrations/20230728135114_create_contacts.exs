defmodule EmailsApp.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :user_id, references(:users, on_delete: :nothing)
      add :contact_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:contacts, [:user_id])
    create index(:contacts, [:contact_id])
  end
end
