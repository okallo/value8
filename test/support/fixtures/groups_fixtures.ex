defmodule EmailsApp.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EmailsApp.Groups` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        name: "some name",
        createdby: 42
      })
      |> EmailsApp.Groups.create_group()

    group
  end

  @doc """
  Generate a group__user.
  """
  def group__user_fixture(attrs \\ %{}) do
    {:ok, group__user} =
      attrs
      |> Enum.into(%{

      })
      |> EmailsApp.Groups.create_group__user()

    group__user
  end
end
