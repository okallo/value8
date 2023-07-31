defmodule EmailsApp.MyGroup.Group_users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_user" do

    field :user_id, :id
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(group_users, attrs) do
    group_users
    |> cast(attrs, [])
    |> validate_required([])
  end
end
