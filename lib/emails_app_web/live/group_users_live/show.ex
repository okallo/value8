defmodule EmailsAppWeb.Group_usersLive.Show do
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
     |> assign(:group_users, MyGroup.get_group_users!(id))}
  end

  defp page_title(:show), do: "Show Group users"
  defp page_title(:edit), do: "Edit Group users"
end
