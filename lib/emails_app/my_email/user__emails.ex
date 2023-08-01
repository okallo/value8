defmodule EmailsApp.MyEmail.User_Emails do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_email" do
    field :status, :boolean, default: false
    field :subject, :string
    field :content, :string
    field :from, :id
    field :to, :id

    timestamps()
  end

  @doc false
  def changeset(user__emails, attrs) do
    user__emails
    |> cast(attrs, [:subject, :content, :status, :from, :to])
    |> validate_required([:subject, :content, :status])
  end
end
