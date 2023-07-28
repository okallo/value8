defmodule EmailsAppWeb.Group_UserControllerTest do
  use EmailsAppWeb.ConnCase

  import EmailsApp.GroupsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all group_users", %{conn: conn} do
      conn = get(conn, ~p"/group_users")
      assert html_response(conn, 200) =~ "Listing Group users"
    end
  end

  describe "new group__user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/group_users/new")
      assert html_response(conn, 200) =~ "New Group  user"
    end
  end

  describe "create group__user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/group_users", group__user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/group_users/#{id}"

      conn = get(conn, ~p"/group_users/#{id}")
      assert html_response(conn, 200) =~ "Group  user #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/group_users", group__user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Group  user"
    end
  end

  describe "edit group__user" do
    setup [:create_group__user]

    test "renders form for editing chosen group__user", %{conn: conn, group__user: group__user} do
      conn = get(conn, ~p"/group_users/#{group__user}/edit")
      assert html_response(conn, 200) =~ "Edit Group  user"
    end
  end

  describe "update group__user" do
    setup [:create_group__user]

    test "redirects when data is valid", %{conn: conn, group__user: group__user} do
      conn = put(conn, ~p"/group_users/#{group__user}", group__user: @update_attrs)
      assert redirected_to(conn) == ~p"/group_users/#{group__user}"

      conn = get(conn, ~p"/group_users/#{group__user}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, group__user: group__user} do
      conn = put(conn, ~p"/group_users/#{group__user}", group__user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Group  user"
    end
  end

  describe "delete group__user" do
    setup [:create_group__user]

    test "deletes chosen group__user", %{conn: conn, group__user: group__user} do
      conn = delete(conn, ~p"/group_users/#{group__user}")
      assert redirected_to(conn) == ~p"/group_users"

      assert_error_sent 404, fn ->
        get(conn, ~p"/group_users/#{group__user}")
      end
    end
  end

  defp create_group__user(_) do
    group__user = group__user_fixture()
    %{group__user: group__user}
  end
end
