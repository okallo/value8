defmodule EmailsApp.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :createdby, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:groups, [:createdby])
  end
end
