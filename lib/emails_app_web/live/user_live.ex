defmodule EmailsAppWeb.UserLive.Index do
  use EmailsAppWeb, :live_view
  alias EmailsApp.Accounts.User
  alias EmailsApp.Accounts
  alias EmailsApp.Repo

  #   def mount(_params, _session, socket) do
  #     users = Repo.all(User)
  #     {:ok, assign(socket, users: users)}
  #   end
  def mount(%{"role" => role} = _params, _session, socket) do
    filtered_users =
      case role do
        "user" -> Accounts.list_user_role(role: :user)
        "admin" -> Accounts.list_user_role(role: :admin)
        "superuser" -> Accounts.list_user_role(role: :superuser)
        "gold" -> Accounts.list_user_role(role: :gold)
      end

    {:ok, assign(socket, users: filtered_users, selected_role: role)}
  end

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    users = Accounts.list_users(current_user.email_address)
    {:ok, assign(socket, users: users, selected_role: nil)}
  end

 def render(assigns) do
    ~H"""
    <div class="container mx-auto mt-6">
      <h2 class="text-2xl font-semibold mb-4">List of Users</h2>
      <div class="mb-4">
        <label class="block text-sm font-medium text-gray-700">Filter by Role:</label>
        <select
          class="mt-1 block w-full p-2 border rounded-md shadow-sm focus:ring focus:ring-opacity-50 focus:border-blue-300"
          phx-change="filter_roles"
        >
          <option value="">All Roles</option>
          <option value="user">User</option>
          <option value="admin">Admin</option>
          <option value="superuser">Superuser</option>
          <option value="gold">Gold</option>
        </select>
      </div>
      <table class="w-full border">
        <thead>
          <tr class="bg-gray-100">
            <th class="p-2">Email</th>
            <th class="p-2">First Name</th>
            <th class="p-2">Last Name</th>
            <th class="p-2">Role</th>
            <th class="p-2">Change Role</th>
          </tr>
        </thead>
        <tbody>
          <%= for user <- @users do %>
            <tr class="border-t hover:bg-gray-100">
              <td class="p-2"><%= user.email_address %></td>
              <td class="p-2"><%= user.first_name %></td>
              <td class="p-2"><%= user.last_name %></td>
              <td class="p-2"><%= user.role %></td>
              <td class="p-2">
                <.form  phx-change="change_role">
                <.input type="hidden" name="user_id" value={user.id}/>
                <select
                  class="mt-1 block w-full p-2 border rounded-md shadow-sm focus:ring focus:ring-opacity-50 focus:border-blue-300"
             
                  name="role"
                >
                  <option value=""></option>
                  <option value="user">User</option>
                  <option value="admin">Admin</option>
                  <option value="superuser">Superuser</option>
                  <option value="gold">Gold</option> 
                </select>
                </.form>
              </td>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end

  def handle_event("filter_roles", %{"role" => role}, socket) do
    {:noreply, assign(socket, selected_role: role)}
  end

  defp role_match?(%User{role: role}, selected_role) do
    case selected_role do
      nil -> true
      ^role -> true
      _ -> false
    end
  end

  defmodule EmailsApp.RolesEnum do
    def atom_to_string(:user), do: "User"
    def atom_to_string(:admin), do: "Admin"
    def atom_to_string(:superuser), do: "Superuser"
    def atom_to_string(:gold), do: "Gold"
    def atom_to_string(_), do: "Unknown"
  end
  def handle_event("change_role", params, socket) do
    role = params["role"]
    user_id = params["user_id"]
    IO.inspect(params["user_id"])
    user = Repo.get!(User, user_id)
    updated_user = change_user_role(user, role)
    {:noreply, assign(socket, users: update_user_in_users(socket.assigns.users, updated_user))}
    
    #{:noreply, socket}
  end

 defp change_user_role(user, role) do
    new_role = role  # Change this to the desired new role
    %{user | role: new_role}
    |> User.role_changeset(%{role: new_role})
    |> Repo.update!()
  end

  defp update_user_in_users(users, updated_user) do
    Enum.map(users, fn u ->
      if u.id == updated_user.id, do: updated_user, else: u
    end)
  end
end
