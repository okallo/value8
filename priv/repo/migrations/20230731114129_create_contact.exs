defmodule EmailsApp.Repo.Migrations.CreateContact do
  use Ecto.Migration

  def change do
    create table(:contact) do
      add :user_id, references(:users, on_delete: :nothing)
      add :contact_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:contact, [:user_id])
    create index(:contact, [:contact_id])
  end
end
