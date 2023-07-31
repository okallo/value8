defmodule EmailsAppWeb.User_EmailsLiveTest do
  use EmailsAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import EmailsApp.MyEmailFixtures

  @create_attrs %{status: true, subject: "some subject", content: "some content"}
  @update_attrs %{status: false, subject: "some updated subject", content: "some updated content"}
  @invalid_attrs %{status: false, subject: nil, content: nil}

  defp create_user__emails(_) do
    user__emails = user__emails_fixture()
    %{user__emails: user__emails}
  end

  describe "Index" do
    setup [:create_user__emails]

    test "lists all user_email", %{conn: conn, user__emails: user__emails} do
      {:ok, _index_live, html} = live(conn, ~p"/user_email")

      assert html =~ "Listing User email"
      assert html =~ user__emails.subject
    end

    test "saves new user__emails", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_email")

      assert index_live |> element("a", "New User  emails") |> render_click() =~
               "New User  emails"

      assert_patch(index_live, ~p"/user_email/new")

      assert index_live
             |> form("#user__emails-form", user__emails: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user__emails-form", user__emails: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_email")

      html = render(index_live)
      assert html =~ "User  emails created successfully"
      assert html =~ "some subject"
    end

    test "updates user__emails in listing", %{conn: conn, user__emails: user__emails} do
      {:ok, index_live, _html} = live(conn, ~p"/user_email")

      assert index_live |> element("#user_email-#{user__emails.id} a", "Edit") |> render_click() =~
               "Edit User  emails"

      assert_patch(index_live, ~p"/user_email/#{user__emails}/edit")

      assert index_live
             |> form("#user__emails-form", user__emails: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user__emails-form", user__emails: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_email")

      html = render(index_live)
      assert html =~ "User  emails updated successfully"
      assert html =~ "some updated subject"
    end

    test "deletes user__emails in listing", %{conn: conn, user__emails: user__emails} do
      {:ok, index_live, _html} = live(conn, ~p"/user_email")

      assert index_live |> element("#user_email-#{user__emails.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_email-#{user__emails.id}")
    end
  end

  describe "Show" do
    setup [:create_user__emails]

    test "displays user__emails", %{conn: conn, user__emails: user__emails} do
      {:ok, _show_live, html} = live(conn, ~p"/user_email/#{user__emails}")

      assert html =~ "Show User  emails"
      assert html =~ user__emails.subject
    end

    test "updates user__emails within modal", %{conn: conn, user__emails: user__emails} do
      {:ok, show_live, _html} = live(conn, ~p"/user_email/#{user__emails}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User  emails"

      assert_patch(show_live, ~p"/user_email/#{user__emails}/show/edit")

      assert show_live
             |> form("#user__emails-form", user__emails: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user__emails-form", user__emails: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_email/#{user__emails}")

      html = render(show_live)
      assert html =~ "User  emails updated successfully"
      assert html =~ "some updated subject"
    end
  end
end
