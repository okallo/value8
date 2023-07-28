defmodule EmailsAppWeb.GroupLive.Index do
  use EmailsAppWeb, :live_view

  alias EmailsApp.UserAction
  alias EmailsApp.UserAction.Group

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :groups, UserAction.list_groups())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Group")
    |> assign(:group, UserAction.get_group!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Group")
    |> assign(:group, %Group{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Groups")
    |> assign(:group, nil)
  end

  @impl true
  def handle_info({EmailsAppWeb.GroupLive.FormComponent, {:saved, group}}, socket) do
    {:noreply, stream_insert(socket, :groups, group)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    group = UserAction.get_group!(id)
    {:ok, _} = UserAction.delete_group(group)

    {:noreply, stream_delete(socket, :groups, group)}
  end
end
