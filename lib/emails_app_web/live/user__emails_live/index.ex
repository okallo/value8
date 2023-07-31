defmodule EmailsAppWeb.User_EmailsLive.Index do
  use EmailsAppWeb, :live_view

  alias EmailsApp.MyEmail
  alias EmailsApp.MyEmail.User_Emails

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :user_email, MyEmail.list_user_email())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User  emails")
    |> assign(:user__emails, MyEmail.get_user__emails!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User  emails")
    |> assign(:user__emails, %User_Emails{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User email")
    |> assign(:user__emails, nil)
  end

  @impl true
  def handle_info({EmailsAppWeb.User_EmailsLive.FormComponent, {:saved, user__emails}}, socket) do
    {:noreply, stream_insert(socket, :user_email, user__emails)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user__emails = MyEmail.get_user__emails!(id)
    {:ok, _} = MyEmail.delete_user__emails(user__emails)

    {:noreply, stream_delete(socket, :user_email, user__emails)}
  end
end
