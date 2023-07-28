defmodule EmailsApp.Accounts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do

    field :user_id, :id
    field :contact_id, :id

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [])
    |> validate_required([])
  end
end
