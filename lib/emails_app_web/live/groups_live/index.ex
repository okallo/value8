defmodule EmailsAppWeb.GroupsLive.Index do
  use EmailsAppWeb, :live_view

  alias EmailsApp.MyGroup
  alias EmailsApp.MyGroup.Groups

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :group, MyGroup.list_group())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Groups")
    |> assign(:groups, MyGroup.get_groups!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Groups")
    |> assign(:groups, %Groups{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Group")
    |> assign(:groups, nil)
  end

  @impl true
  def handle_info({EmailsAppWeb.GroupsLive.FormComponent, {:saved, groups}}, socket) do
    {:noreply, stream_insert(socket, :group, groups)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    groups = MyGroup.get_groups!(id)
    {:ok, _} = MyGroup.delete_groups(groups)

    {:noreply, stream_delete(socket, :group, groups)}
  end
end
