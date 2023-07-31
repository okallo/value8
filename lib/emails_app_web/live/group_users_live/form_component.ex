defmodule EmailsAppWeb.Group_usersLive.FormComponent do
  use EmailsAppWeb, :live_component

  alias EmailsApp.MyGroup

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage group_users records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="group_users-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Group users</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{group_users: group_users} = assigns, socket) do
    changeset = MyGroup.change_group_users(group_users)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"group_users" => group_users_params}, socket) do
    changeset =
      socket.assigns.group_users
      |> MyGroup.change_group_users(group_users_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"group_users" => group_users_params}, socket) do
    save_group_users(socket, socket.assigns.action, group_users_params)
  end

  defp save_group_users(socket, :edit, group_users_params) do
    case MyGroup.update_group_users(socket.assigns.group_users, group_users_params) do
      {:ok, group_users} ->
        notify_parent({:saved, group_users})

        {:noreply,
         socket
         |> put_flash(:info, "Group users updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_group_users(socket, :new, group_users_params) do
    case MyGroup.create_group_users(group_users_params) do
      {:ok, group_users} ->
        notify_parent({:saved, group_users})

        {:noreply,
         socket
         |> put_flash(:info, "Group users created successfully")
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
