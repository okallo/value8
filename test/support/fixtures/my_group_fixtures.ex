defmodule EmailsApp.MyGroupFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EmailsApp.MyGroup` context.
  """

  @doc """
  Generate a groups.
  """
  def groups_fixture(attrs \\ %{}) do
    {:ok, groups} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> EmailsApp.MyGroup.create_groups()

    groups
  end

  @doc """
  Generate a group_users.
  """
  def group_users_fixture(attrs \\ %{}) do
    {:ok, group_users} =
      attrs
      |> Enum.into(%{

      })
      |> EmailsApp.MyGroup.create_group_users()

    group_users
  end
end
