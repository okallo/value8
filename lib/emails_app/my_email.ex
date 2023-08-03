defmodule EmailsApp.MyEmail do
  @moduledoc """
  The MyEmail context.
  """

  import Ecto.Query, warn: false
  alias EmailsApp.Repo

  alias EmailsApp.MyEmail.User_Emails
  # defp current_user_id(conn) do
  #     Guardian.Plug.current_resource(conn, :user_id)
  #   end
  @doc """
  Returns the list of user_email.

  """

  #email = "user@example.com"
  def list_user_email do
    Repo.all(User_Emails)
  end
  def list_user_email_inbox(email) do
    query =
      from e in User_Emails,
      where: e.to_user == ^email
    Repo.all(query)
  end

   def list_user_email_sent(email) do
    query =
      from e in User_Emails,
      where: e.from_user == ^email
    Repo.all(query)
  end

  @doc """
  Gets a single user__emails.

  Raises `Ecto.NoResultsError` if the User  emails does not exist.


  """
  def get_user__emails!(id), do: Repo.get!(User_Emails, id)

  @doc """
  Creates a user__emails.

  """
  def create_user__emails(attrs \\ %{}) do
    %User_Emails{}
    |> User_Emails.changeset(attrs)
    |> Repo.insert()
  end

 

  @doc """
  Updates a user__emails.


  """
  def update_user__emails(%User_Emails{} = user__emails, attrs) do
    user__emails
    |> User_Emails.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user__emails.

  """
  def delete_user__emails(%User_Emails{} = user__emails) do
    Repo.delete(user__emails)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user__emails changes.

  """
  def change_user__emails(%User_Emails{} = user__emails, attrs \\ %{}) do
    User_Emails.changeset(user__emails, attrs)
  end
end
