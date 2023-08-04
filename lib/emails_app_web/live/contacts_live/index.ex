defmodule EmailsAppWeb.ContactsLive.Index do
  use EmailsAppWeb, :live_view

  alias EmailsApp.Accounts
  alias EmailsApp.Accounts.Contacts

  @impl true
  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    contats = Accounts.get_contacts_users(current_user.id)

    contacts =
      Enum.map(contats, fn item ->
        Accounts.get_user!(item.contact_id)
      end)

    IO.inspect(contacts)
    {:ok, stream(socket, :contact,contacts )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Contacts")
    |> assign(:contacts, Accounts.get_contacts!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Contacts")
    |> assign(:contacts, %Contacts{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contact")
    |> assign(:contacts, nil)
  end

  @impl true
  def handle_info({EmailsAppWeb.ContactsLive.FormComponent, {:saved, contacts}}, socket) do
    {:noreply, stream_insert(socket, :contact, contacts)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    contacts = Accounts.get_contacts!(id)
    {:ok, _} = Accounts.delete_contacts(contacts)

    {:noreply, stream_delete(socket, :contact, contacts)}
  end
end
