defmodule EmailsApp.Repo.Migrations.CreateUserEmail do
  use Ecto.Migration
  def change do
    execute("CREATE TYPE status AS ENUM ('sent','draft','not_sent','reply');")
    create table(:user_emails) do
      add :subject, :string
      add :content, :text
      add :status, :status, null: false
      add :from_user, references(:users, column: :email_address, type: :citext, on_delete: :nothing)
      add :to_user, references(:users, column: :email_address, type: :citext, on_delete: :nothing)
      timestamps()
    end
  end
end
