defmodule EmailsApp.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""
    execute("CREATE TYPE role AS ENUM ('user','admin','superuser','gold');")

    create table(:users) do
      add :email_address, :citext, unique: true, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :msisdn, :string, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime
      add :role, :role, null: false
      timestamps()
    end

    create unique_index(:users, [:email_address])

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
