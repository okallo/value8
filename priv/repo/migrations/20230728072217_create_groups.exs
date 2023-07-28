defmodule EmailsApp.Repo.Migrations.CreateGroups do
   use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string, null: false

      add :createdby, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:groups, [:name], unique: true)
    create index(:groups, [:createdby])
  end
end
