defmodule EmailsAppWeb.ContactsLive.FormComponent do
  use EmailsAppWeb, :live_component

  alias EmailsApp.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage contacts records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="contacts-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Contacts</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{contacts: contacts} = assigns, socket) do
    changeset = Accounts.change_contacts(contacts)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"contacts" => contacts_params}, socket) do
    changeset =
      socket.assigns.contacts
      |> Accounts.change_contacts(contacts_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"contacts" => contacts_params}, socket) do
    save_contacts(socket, socket.assigns.action, contacts_params)
  end

  defp save_contacts(socket, :edit, contacts_params) do
    case Accounts.update_contacts(socket.assigns.contacts, contacts_params) do
      {:ok, contacts} ->
        notify_parent({:saved, contacts})

        {:noreply,
         socket
         |> put_flash(:info, "Contacts updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_contacts(socket, :new, contacts_params) do
    case Accounts.create_contacts(contacts_params) do
      {:ok, contacts} ->
        notify_parent({:saved, contacts})

        {:noreply,
         socket
         |> put_flash(:info, "Contacts created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
