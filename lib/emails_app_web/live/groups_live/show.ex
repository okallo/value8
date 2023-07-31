defmodule EmailsAppWeb.GroupsLive.Show do
  use EmailsAppWeb, :live_view

  alias EmailsApp.MyGroup

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:groups, MyGroup.get_groups!(id))}
  end

  defp page_title(:show), do: "Show Groups"
  defp page_title(:edit), do: "Edit Groups"
end
