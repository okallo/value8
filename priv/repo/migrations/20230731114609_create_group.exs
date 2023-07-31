defmodule EmailsApp.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:group) do
      add :name, :string, null: false
      add :created_by, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:group, [:name], unique: true)
    create index(:group, [:created_by])
  end
end
