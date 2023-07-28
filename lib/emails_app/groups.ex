defmodule EmailsApp.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  alias EmailsApp.Repo

  alias EmailsApp.Groups.Group

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{data: %Group{}}

  """
  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end

  alias EmailsApp.Groups.Group_User

  @doc """
  Returns the list of group_users.

  ## Examples

      iex> list_group_users()
      [%Group_User{}, ...]

  """
  def list_group_users do
    Repo.all(Group_User)
  end

  @doc """
  Gets a single group__user.

  Raises `Ecto.NoResultsError` if the Group  user does not exist.

  ## Examples

      iex> get_group__user!(123)
      %Group_User{}

      iex> get_group__user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group__user!(id), do: Repo.get!(Group_User, id)

  @doc """
  Creates a group__user.

  ## Examples

      iex> create_group__user(%{field: value})
      {:ok, %Group_User{}}

      iex> create_group__user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group__user(attrs \\ %{}) do
    %Group_User{}
    |> Group_User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group__user.

  ## Examples

      iex> update_group__user(group__user, %{field: new_value})
      {:ok, %Group_User{}}

      iex> update_group__user(group__user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group__user(%Group_User{} = group__user, attrs) do
    group__user
    |> Group_User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group__user.

  ## Examples

      iex> delete_group__user(group__user)
      {:ok, %Group_User{}}

      iex> delete_group__user(group__user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group__user(%Group_User{} = group__user) do
    Repo.delete(group__user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group__user changes.

  ## Examples

      iex> change_group__user(group__user)
      %Ecto.Changeset{data: %Group_User{}}

  """
  def change_group__user(%Group_User{} = group__user, attrs \\ %{}) do
    Group_User.changeset(group__user, attrs)
  end
end
