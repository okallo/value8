defmodule EmailsAppWeb.User_EmailsLive.Failed do
  use EmailsAppWeb, :live_view
  alias EmailsApp.MyEmail
  alias EmailsApp.MyEmail.User_Emails

  @impl true
  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    user_email_stream = stream(socket, :user_email, MyEmail.list_user_email_draft(current_user.email_address))
    {:ok, socket |> assign(:user_email_stream, user_email_stream)}
  end
end
