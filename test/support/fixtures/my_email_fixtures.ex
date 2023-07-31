defmodule EmailsApp.MyEmailFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EmailsApp.MyEmail` context.
  """

  @doc """
  Generate a user__emails.
  """
  def user__emails_fixture(attrs \\ %{}) do
    {:ok, user__emails} =
      attrs
      |> Enum.into(%{
        status: true,
        subject: "some subject",
        content: "some content"
      })
      |> EmailsApp.MyEmail.create_user__emails()

    user__emails
  end
end
