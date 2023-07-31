defmodule EmailsApp.Repo.Migrations.CreateUserEmail do
  use Ecto.Migration
  def change do
    create table(:user_email) do
      add :subject, :string
      add :content, :string
      add :status, :boolean, default: false, null: false
      add :from, references(:users, on_delete: :nothing)
      add :to, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_email, [:from])
    create index(:user_email, [:to])
  end
end
