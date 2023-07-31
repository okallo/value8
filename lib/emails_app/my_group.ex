defmodule EmailsApp.MyGroup do
  @moduledoc """
  The MyGroup context.
  """

  import Ecto.Query, warn: false
  alias EmailsApp.Repo

  alias EmailsApp.MyGroup.Groups

  @doc """
  Returns the list of group.

  ## Examples

      iex> list_group()
      [%Groups{}, ...]

  """
  def list_group do
    Repo.all(Groups)
  end

  @doc """
  Gets a single groups.

  Raises `Ecto.NoResultsError` if the Groups does not exist.

  ## Examples

      iex> get_groups!(123)
      %Groups{}

      iex> get_groups!(456)
      ** (Ecto.NoResultsError)

  """
  def get_groups!(id), do: Repo.get!(Groups, id)

  @doc """
  Creates a groups.

  ## Examples

      iex> create_groups(%{field: value})
      {:ok, %Groups{}}

      iex> create_groups(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_groups(attrs \\ %{}) do
    %Groups{}
    |> Groups.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a groups.

  ## Examples

      iex> update_groups(groups, %{field: new_value})
      {:ok, %Groups{}}

      iex> update_groups(groups, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_groups(%Groups{} = groups, attrs) do
    groups
    |> Groups.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a groups.

  ## Examples

      iex> delete_groups(groups)
      {:ok, %Groups{}}

      iex> delete_groups(groups)
      {:error, %Ecto.Changeset{}}

  """
  def delete_groups(%Groups{} = groups) do
    Repo.delete(groups)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking groups changes.

  ## Examples

      iex> change_groups(groups)
      %Ecto.Changeset{data: %Groups{}}

  """
  def change_groups(%Groups{} = groups, attrs \\ %{}) do
    Groups.changeset(groups, attrs)
  end

  alias EmailsApp.MyGroup.Group_users

  @doc """
  Returns the list of group_user.

  ## Examples

      iex> list_group_user()
      [%Group_users{}, ...]

  """
  def list_group_user do
    Repo.all(Group_users)
  end

  @doc """
  Gets a single group_users.

  Raises `Ecto.NoResultsError` if the Group users does not exist.

  ## Examples

      iex> get_group_users!(123)
      %Group_users{}

      iex> get_group_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group_users!(id), do: Repo.get!(Group_users, id)

  @doc """
  Creates a group_users.

  ## Examples

      iex> create_group_users(%{field: value})
      {:ok, %Group_users{}}

      iex> create_group_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group_users(attrs \\ %{}) do
    %Group_users{}
    |> Group_users.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group_users.

  ## Examples

      iex> update_group_users(group_users, %{field: new_value})
      {:ok, %Group_users{}}

      iex> update_group_users(group_users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group_users(%Group_users{} = group_users, attrs) do
    group_users
    |> Group_users.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group_users.

  ## Examples

      iex> delete_group_users(group_users)
      {:ok, %Group_users{}}

      iex> delete_group_users(group_users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group_users(%Group_users{} = group_users) do
    Repo.delete(group_users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group_users changes.

  ## Examples

      iex> change_group_users(group_users)
      %Ecto.Changeset{data: %Group_users{}}

  """
  def change_group_users(%Group_users{} = group_users, attrs \\ %{}) do
    Group_users.changeset(group_users, attrs)
  end
end
