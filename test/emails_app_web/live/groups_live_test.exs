defmodule EmailsAppWeb.GroupsLiveTest do
  use EmailsAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import EmailsApp.MyGroupFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_groups(_) do
    groups = groups_fixture()
    %{groups: groups}
  end

  describe "Index" do
    setup [:create_groups]

    test "lists all group", %{conn: conn, groups: groups} do
      {:ok, _index_live, html} = live(conn, ~p"/group")

      assert html =~ "Listing Group"
      assert html =~ groups.name
    end

    test "saves new groups", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/group")

      assert index_live |> element("a", "New Groups") |> render_click() =~
               "New Groups"

      assert_patch(index_live, ~p"/group/new")

      assert index_live
             |> form("#groups-form", groups: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#groups-form", groups: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/group")

      html = render(index_live)
      assert html =~ "Groups created successfully"
      assert html =~ "some name"
    end

    test "updates groups in listing", %{conn: conn, groups: groups} do
      {:ok, index_live, _html} = live(conn, ~p"/group")

      assert index_live |> element("#group-#{groups.id} a", "Edit") |> render_click() =~
               "Edit Groups"

      assert_patch(index_live, ~p"/group/#{groups}/edit")

      assert index_live
             |> form("#groups-form", groups: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#groups-form", groups: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/group")

      html = render(index_live)
      assert html =~ "Groups updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes groups in listing", %{conn: conn, groups: groups} do
      {:ok, index_live, _html} = live(conn, ~p"/group")

      assert index_live |> element("#group-#{groups.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#group-#{groups.id}")
    end
  end

  describe "Show" do
    setup [:create_groups]

    test "displays groups", %{conn: conn, groups: groups} do
      {:ok, _show_live, html} = live(conn, ~p"/group/#{groups}")

      assert html =~ "Show Groups"
      assert html =~ groups.name
    end

    test "updates groups within modal", %{conn: conn, groups: groups} do
      {:ok, show_live, _html} = live(conn, ~p"/group/#{groups}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Groups"

      assert_patch(show_live, ~p"/group/#{groups}/show/edit")

      assert show_live
             |> form("#groups-form", groups: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#groups-form", groups: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/group/#{groups}")

      html = render(show_live)
      assert html =~ "Groups updated successfully"
      assert html =~ "some updated name"
    end
  end
end
