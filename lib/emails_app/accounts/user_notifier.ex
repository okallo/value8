defmodule EmailsApp.Accounts.UserNotifier do
  import Swoosh.Email

  alias EmailsApp.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body, from) do
    email =
      new()
      |> to(recipient)
      |> from({"EmailsApp", from})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(
      user.email_address,
      "Confirmation instructions",
      """

      ==============================

      Hi #{user.email_address},

      You can confirm your account by visiting the URL below:

      #{url}

      If you didn't create an account with us, please ignore this.

      ==============================
      """,
      "admin@mail.com"
    )
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(
      user.email_address,
      "Reset password instructions",
      """

      ==============================

      Hi #{user.email_address},

      You can reset your password by visiting the URL below:

      #{url}

      If you didn't request this change, please ignore this.

      ==============================
      """,
      "admin@mail.com"
    )
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(
      user.email_address,
      "Update email instructions",
      """

      ==============================

      Hi #{user.email_address},

      You can change your email by visiting the URL below:

      #{url}

      If you didn't request this change, please ignore this.

      ==============================
      """,
      "admin@mail.com"
    )
  end

  def send_email(%{
        "content" => content,
        "from_user" => from_user,
        "subject" => subject,
        "to_user" => to_user
      }) do
    deliver(to_user, subject, content, from_user)
  end
end
