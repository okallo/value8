defmodule EmailsApp.MyEmail do
  @moduledoc """
  The MyEmail context.
  """

  import Ecto.Query, warn: false
  alias EmailsApp.Repo

  alias EmailsApp.MyEmail.User_Emails

  @doc """
  Returns the list of user_email.

  ## Examples

      iex> list_user_email()
      [%User_Emails{}, ...]

  """
  def list_user_email do
    Repo.all(User_Emails)
  end

  @doc """
  Gets a single user__emails.

  Raises `Ecto.NoResultsError` if the User  emails does not exist.

  ## Examples

      iex> get_user__emails!(123)
      %User_Emails{}

      iex> get_user__emails!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user__emails!(id), do: Repo.get!(User_Emails, id)

  @doc """
  Creates a user__emails.

  ## Examples

      iex> create_user__emails(%{field: value})
      {:ok, %User_Emails{}}

      iex> create_user__emails(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user__emails(attrs \\ %{}) do
    %User_Emails{}
    |> User_Emails.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user__emails.

  ## Examples

      iex> update_user__emails(user__emails, %{field: new_value})
      {:ok, %User_Emails{}}

      iex> update_user__emails(user__emails, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user__emails(%User_Emails{} = user__emails, attrs) do
    user__emails
    |> User_Emails.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user__emails.

  ## Examples

      iex> delete_user__emails(user__emails)
      {:ok, %User_Emails{}}

      iex> delete_user__emails(user__emails)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user__emails(%User_Emails{} = user__emails) do
    Repo.delete(user__emails)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user__emails changes.

  ## Examples

      iex> change_user__emails(user__emails)
      %Ecto.Changeset{data: %User_Emails{}}

  """
  def change_user__emails(%User_Emails{} = user__emails, attrs \\ %{}) do
    User_Emails.changeset(user__emails, attrs)
  end
end
