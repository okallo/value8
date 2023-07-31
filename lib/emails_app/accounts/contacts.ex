defmodule EmailsApp.Accounts.Contacts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contact" do

    field :user_id, :id
    field :contact_id, :id

    timestamps()
  end

  @doc false
  def changeset(contacts, attrs) do
    contacts
    |> cast(attrs, [])
    |> validate_required([])
  end
end
