defmodule EmailsApp.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EmailsApp.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> EmailsApp.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{

      })
      |> EmailsApp.Accounts.create_contact()

    contact
  end

  @doc """
  Generate a contacts.
  """
  def contacts_fixture(attrs \\ %{}) do
    {:ok, contacts} =
      attrs
      |> Enum.into(%{

      })
      |> EmailsApp.Accounts.create_contacts()

    contacts
  end

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        full_name: "some full_name",
        email_address: "some email_address"
      })
      |> EmailsApp.Accounts.create_contact()

    contact
  end
end
