defmodule EmailsAppWeb.ContactsLiveTest do
  use EmailsAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import EmailsApp.AccountsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_contacts(_) do
    contacts = contacts_fixture()
    %{contacts: contacts}
  end

  describe "Index" do
    setup [:create_contacts]

    test "lists all contact", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/contact")

      assert html =~ "Listing Contact"
    end

    test "saves new contacts", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/contact")

      assert index_live |> element("a", "New Contacts") |> render_click() =~
               "New Contacts"

      assert_patch(index_live, ~p"/contact/new")

      assert index_live
             |> form("#contacts-form", contacts: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#contacts-form", contacts: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/contact")

      html = render(index_live)
      assert html =~ "Contacts created successfully"
    end

    test "updates contacts in listing", %{conn: conn, contacts: contacts} do
      {:ok, index_live, _html} = live(conn, ~p"/contact")

      assert index_live |> element("#contact-#{contacts.id} a", "Edit") |> render_click() =~
               "Edit Contacts"

      assert_patch(index_live, ~p"/contact/#{contacts}/edit")

      assert index_live
             |> form("#contacts-form", contacts: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#contacts-form", contacts: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/contact")

      html = render(index_live)
      assert html =~ "Contacts updated successfully"
    end

    test "deletes contacts in listing", %{conn: conn, contacts: contacts} do
      {:ok, index_live, _html} = live(conn, ~p"/contact")

      assert index_live |> element("#contact-#{contacts.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#contact-#{contacts.id}")
    end
  end

  describe "Show" do
    setup [:create_contacts]

    test "displays contacts", %{conn: conn, contacts: contacts} do
      {:ok, _show_live, html} = live(conn, ~p"/contact/#{contacts}")

      assert html =~ "Show Contacts"
    end

    test "updates contacts within modal", %{conn: conn, contacts: contacts} do
      {:ok, show_live, _html} = live(conn, ~p"/contact/#{contacts}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Contacts"

      assert_patch(show_live, ~p"/contact/#{contacts}/show/edit")

      assert show_live
             |> form("#contacts-form", contacts: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#contacts-form", contacts: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/contact/#{contacts}")

      html = render(show_live)
      assert html =~ "Contacts updated successfully"
    end
  end
end
