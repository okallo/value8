defmodule EmailsAppWeb.Group_usersLive.Index do
  use EmailsAppWeb, :live_view

  alias EmailsApp.MyGroup
  alias EmailsApp.MyGroup.Group_users

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :group_user, MyGroup.list_group_user())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Group users")
    |> assign(:group_users, MyGroup.get_group_users!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Group users")
    |> assign(:group_users, %Group_users{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Group user")
    |> assign(:group_users, nil)
  end

  @impl true
  def handle_info({EmailsAppWeb.Group_usersLive.FormComponent, {:saved, group_users}}, socket) do
    {:noreply, stream_insert(socket, :group_user, group_users)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    group_users = MyGroup.get_group_users!(id)
    {:ok, _} = MyGroup.delete_group_users(group_users)

    {:noreply, stream_delete(socket, :group_user, group_users)}
  end
end
