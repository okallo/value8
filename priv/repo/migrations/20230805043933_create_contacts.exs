defmodule EmailsApp.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""
    create table(:contacts) do
      add :full_name, :string
      add :email_address, :citext

      timestamps()
    end
  end
end
