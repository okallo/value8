defmodule EmailsApp.MyGroup.Groups do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group" do
    field :name, :string
    field :created_by, :id

    timestamps()
  end

  @doc false
  def changeset(groups, attrs) do
    groups
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
