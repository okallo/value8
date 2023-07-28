defmodule EmailsAppWeb.Group_UserController do
  use EmailsAppWeb, :controller

  alias EmailsApp.Groups
  alias EmailsApp.Groups.Group_User

  def index(conn, _params) do
    group_users = Groups.list_group_users()
    render(conn, :index, group_users: group_users)
  end

  def new(conn, _params) do
    changeset = Groups.change_group__user(%Group_User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"group__user" => group__user_params}) do
    case Groups.create_group__user(group__user_params) do
      {:ok, group__user} ->
        conn
        |> put_flash(:info, "Group  user created successfully.")
        |> redirect(to: ~p"/group_users/#{group__user}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    group__user = Groups.get_group__user!(id)
    render(conn, :show, group__user: group__user)
  end

  def edit(conn, %{"id" => id}) do
    group__user = Groups.get_group__user!(id)
    changeset = Groups.change_group__user(group__user)
    render(conn, :edit, group__user: group__user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "group__user" => group__user_params}) do
    group__user = Groups.get_group__user!(id)

    case Groups.update_group__user(group__user, group__user_params) do
      {:ok, group__user} ->
        conn
        |> put_flash(:info, "Group  user updated successfully.")
        |> redirect(to: ~p"/group_users/#{group__user}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, group__user: group__user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    group__user = Groups.get_group__user!(id)
    {:ok, _group__user} = Groups.delete_group__user(group__user)

    conn
    |> put_flash(:info, "Group  user deleted successfully.")
    |> redirect(to: ~p"/group_users")
  end
end
