defmodule EmailsApp.GroupsTest do
  use EmailsApp.DataCase

  alias EmailsApp.Groups

  describe "groups" do
    alias EmailsApp.Groups.Group

    import EmailsApp.GroupsFixtures

    @invalid_attrs %{name: nil, createdby: nil}

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Groups.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Groups.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      valid_attrs = %{name: "some name", createdby: 42}

      assert {:ok, %Group{} = group} = Groups.create_group(valid_attrs)
      assert group.name == "some name"
      assert group.createdby == 42
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Groups.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      update_attrs = %{name: "some updated name", createdby: 43}

      assert {:ok, %Group{} = group} = Groups.update_group(group, update_attrs)
      assert group.name == "some updated name"
      assert group.createdby == 43
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.update_group(group, @invalid_attrs)
      assert group == Groups.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Groups.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Groups.change_group(group)
    end
  end

  describe "group_users" do
    alias EmailsApp.Groups.Group_User

    import EmailsApp.GroupsFixtures

    @invalid_attrs %{}

    test "list_group_users/0 returns all group_users" do
      group__user = group__user_fixture()
      assert Groups.list_group_users() == [group__user]
    end

    test "get_group__user!/1 returns the group__user with given id" do
      group__user = group__user_fixture()
      assert Groups.get_group__user!(group__user.id) == group__user
    end

    test "create_group__user/1 with valid data creates a group__user" do
      valid_attrs = %{}

      assert {:ok, %Group_User{} = group__user} = Groups.create_group__user(valid_attrs)
    end

    test "create_group__user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Groups.create_group__user(@invalid_attrs)
    end

    test "update_group__user/2 with valid data updates the group__user" do
      group__user = group__user_fixture()
      update_attrs = %{}

      assert {:ok, %Group_User{} = group__user} = Groups.update_group__user(group__user, update_attrs)
    end

    test "update_group__user/2 with invalid data returns error changeset" do
      group__user = group__user_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.update_group__user(group__user, @invalid_attrs)
      assert group__user == Groups.get_group__user!(group__user.id)
    end

    test "delete_group__user/1 deletes the group__user" do
      group__user = group__user_fixture()
      assert {:ok, %Group_User{}} = Groups.delete_group__user(group__user)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_group__user!(group__user.id) end
    end

    test "change_group__user/1 returns a group__user changeset" do
      group__user = group__user_fixture()
      assert %Ecto.Changeset{} = Groups.change_group__user(group__user)
    end
  end
end
