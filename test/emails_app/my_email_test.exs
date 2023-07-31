defmodule EmailsApp.MyEmailTest do
  use EmailsApp.DataCase

  alias EmailsApp.MyEmail

  describe "user_email" do
    alias EmailsApp.MyEmail.User_Emails

    import EmailsApp.MyEmailFixtures

    @invalid_attrs %{status: nil, subject: nil, content: nil}

    test "list_user_email/0 returns all user_email" do
      user__emails = user__emails_fixture()
      assert MyEmail.list_user_email() == [user__emails]
    end

    test "get_user__emails!/1 returns the user__emails with given id" do
      user__emails = user__emails_fixture()
      assert MyEmail.get_user__emails!(user__emails.id) == user__emails
    end

    test "create_user__emails/1 with valid data creates a user__emails" do
      valid_attrs = %{status: true, subject: "some subject", content: "some content"}

      assert {:ok, %User_Emails{} = user__emails} = MyEmail.create_user__emails(valid_attrs)
      assert user__emails.status == true
      assert user__emails.subject == "some subject"
      assert user__emails.content == "some content"
    end

    test "create_user__emails/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MyEmail.create_user__emails(@invalid_attrs)
    end

    test "update_user__emails/2 with valid data updates the user__emails" do
      user__emails = user__emails_fixture()
      update_attrs = %{status: false, subject: "some updated subject", content: "some updated content"}

      assert {:ok, %User_Emails{} = user__emails} = MyEmail.update_user__emails(user__emails, update_attrs)
      assert user__emails.status == false
      assert user__emails.subject == "some updated subject"
      assert user__emails.content == "some updated content"
    end

    test "update_user__emails/2 with invalid data returns error changeset" do
      user__emails = user__emails_fixture()
      assert {:error, %Ecto.Changeset{}} = MyEmail.update_user__emails(user__emails, @invalid_attrs)
      assert user__emails == MyEmail.get_user__emails!(user__emails.id)
    end

    test "delete_user__emails/1 deletes the user__emails" do
      user__emails = user__emails_fixture()
      assert {:ok, %User_Emails{}} = MyEmail.delete_user__emails(user__emails)
      assert_raise Ecto.NoResultsError, fn -> MyEmail.get_user__emails!(user__emails.id) end
    end

    test "change_user__emails/1 returns a user__emails changeset" do
      user__emails = user__emails_fixture()
      assert %Ecto.Changeset{} = MyEmail.change_user__emails(user__emails)
    end
  end
end
