defmodule EmailsAppWeb.GroupsLive.FormComponent do
  use EmailsAppWeb, :live_component

  alias EmailsApp.MyGroup

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage groups records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="groups-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Groups</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{groups: groups} = assigns, socket) do
    changeset = MyGroup.change_groups(groups)
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"groups" => groups_params}, socket) do
    changeset =
      socket.assigns.groups
      |> MyGroup.change_groups(groups_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"groups" => groups_params}, socket) do
    save_groups(socket, socket.assigns.action, groups_params)
  end

  defp save_groups(socket, :edit, groups_params) do
    case MyGroup.update_groups(socket.assigns.groups, groups_params) do
      {:ok, groups} ->
        notify_parent({:saved, groups})

        {:noreply,
         socket
         |> put_flash(:info, "Groups updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_groups(socket, :new, groups_params) do
    case MyGroup.create_groups(groups_params) do
      {:ok, groups} ->
        notify_parent({:saved, groups})

        {:noreply,
         socket
         |> put_flash(:info, "Groups created successfully")
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
