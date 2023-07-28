defmodule EmailsApp.UserActionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EmailsApp.UserAction` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> EmailsApp.UserAction.create_group()

    group
  end
end
