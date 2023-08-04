defmodule EmailsAppWeb.ContactsLive.Add do
  use EmailsAppWeb, :live_view

  alias EmailsApp.Accounts

  @impl true
  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    {:ok, stream(socket, :users, Accounts.list_users(current_user.email_address))}
  end
end