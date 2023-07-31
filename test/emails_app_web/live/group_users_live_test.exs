defmodule EmailsAppWeb.Group_usersLiveTest do
  use EmailsAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import EmailsApp.MyGroupFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_group_users(_) do
    group_users = group_users_fixture()
    %{group_users: group_users}
  end

  describe "Index" do
    setup [:create_group_users]

    test "lists all group_user", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/group_user")

      assert html =~ "Listing Group user"
    end

    test "saves new group_users", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/group_user")

      assert index_live |> element("a", "New Group users") |> render_click() =~
               "New Group users"

      assert_patch(index_live, ~p"/group_user/new")

      assert index_live
             |> form("#group_users-form", group_users: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#group_users-form", group_users: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/group_user")

      html = render(index_live)
      assert html =~ "Group users created successfully"
    end

    test "updates group_users in listing", %{conn: conn, group_users: group_users} do
      {:ok, index_live, _html} = live(conn, ~p"/group_user")

      assert index_live |> element("#group_user-#{group_users.id} a", "Edit") |> render_click() =~
               "Edit Group users"

      assert_patch(index_live, ~p"/group_user/#{group_users}/edit")

      assert index_live
             |> form("#group_users-form", group_users: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#group_users-form", group_users: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/group_user")

      html = render(index_live)
      assert html =~ "Group users updated successfully"
    end

    test "deletes group_users in listing", %{conn: conn, group_users: group_users} do
      {:ok, index_live, _html} = live(conn, ~p"/group_user")

      assert index_live |> element("#group_user-#{group_users.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#group_user-#{group_users.id}")
    end
  end

  describe "Show" do
    setup [:create_group_users]

    test "displays group_users", %{conn: conn, group_users: group_users} do
      {:ok, _show_live, html} = live(conn, ~p"/group_user/#{group_users}")

      assert html =~ "Show Group users"
    end

    test "updates group_users within modal", %{conn: conn, group_users: group_users} do
      {:ok, show_live, _html} = live(conn, ~p"/group_user/#{group_users}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Group users"

      assert_patch(show_live, ~p"/group_user/#{group_users}/show/edit")

      assert show_live
             |> form("#group_users-form", group_users: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#group_users-form", group_users: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/group_user/#{group_users}")

      html = render(show_live)
      assert html =~ "Group users updated successfully"
    end
  end
end
