defmodule EmailsApp.MyEmail.User_Emails do
  use Ecto.Schema
  import Ecto.Changeset
  alias EmailsApp.Accounts.User
  import EctoEnum
 

  defenum(StatusEnum, [
  "sent",
  "draft",
  "not_sent",
  "reply"
])


  schema "user_emails" do
    field :status, StatusEnum, default: :draft
    field :subject, :string
    field :content, :string
    belongs_to :from, User, references: :email_address, type: :string, foreign_key: :from_user
    belongs_to :to, User, references: :email_address, type: :string, foreign_key: :to_user

    timestamps()
  end

  @doc false
  def changeset(user__emails, attrs) do
    user__emails
    |> cast(attrs, [:subject, :content, :from_user, :to_user, :status])
    |> validate_required([:subject, :content])
  end

  def update_status_changeset(user_email, status) do
    changeset(user_email, %{status: status})
  end
end
