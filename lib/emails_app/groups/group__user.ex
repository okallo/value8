defmodule EmailsApp.Groups.Group_User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_users" do

    field :group_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(group__user, attrs) do
    group__user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
