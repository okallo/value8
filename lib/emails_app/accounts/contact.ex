defmodule EmailsApp.Accounts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :full_name, :string
    field :email_address, :string

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:full_name, :email_address])
    |> validate_required([:full_name, :email_address])
  end
end
