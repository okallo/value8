defmodule EmailsAppWeb.ContactControllerTest do
  use EmailsAppWeb.ConnCase

  import EmailsApp.AccountsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all contacts", %{conn: conn} do
      conn = get(conn, ~p"/contacts")
      assert html_response(conn, 200) =~ "Listing Contacts"
    end
  end

  describe "new contact" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/contacts/new")
      assert html_response(conn, 200) =~ "New Contact"
    end
  end

  describe "create contact" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/contacts", contact: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/contacts/#{id}"

      conn = get(conn, ~p"/contacts/#{id}")
      assert html_response(conn, 200) =~ "Contact #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/contacts", contact: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Contact"
    end
  end

  describe "edit contact" do
    setup [:create_contact]

    test "renders form for editing chosen contact", %{conn: conn, contact: contact} do
      conn = get(conn, ~p"/contacts/#{contact}/edit")
      assert html_response(conn, 200) =~ "Edit Contact"
    end
  end

  describe "update contact" do
    setup [:create_contact]

    test "redirects when data is valid", %{conn: conn, contact: contact} do
      conn = put(conn, ~p"/contacts/#{contact}", contact: @update_attrs)
      assert redirected_to(conn) == ~p"/contacts/#{contact}"

      conn = get(conn, ~p"/contacts/#{contact}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, contact: contact} do
      conn = put(conn, ~p"/contacts/#{contact}", contact: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Contact"
    end
  end

  describe "delete contact" do
    setup [:create_contact]

    test "deletes chosen contact", %{conn: conn, contact: contact} do
      conn = delete(conn, ~p"/contacts/#{contact}")
      assert redirected_to(conn) == ~p"/contacts"

      assert_error_sent 404, fn ->
        get(conn, ~p"/contacts/#{contact}")
      end
    end
  end

  defp create_contact(_) do
    contact = contact_fixture()
    %{contact: contact}
  end
end
