defmodule EmailsApp.MyGroupTest do
  use EmailsApp.DataCase

  alias EmailsApp.MyGroup

  describe "group" do
    alias EmailsApp.MyGroup.Groups

    import EmailsApp.MyGroupFixtures

    @invalid_attrs %{name: nil}

    test "list_group/0 returns all group" do
      groups = groups_fixture()
      assert MyGroup.list_group() == [groups]
    end

    test "get_groups!/1 returns the groups with given id" do
      groups = groups_fixture()
      assert MyGroup.get_groups!(groups.id) == groups
    end

    test "create_groups/1 with valid data creates a groups" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Groups{} = groups} = MyGroup.create_groups(valid_attrs)
      assert groups.name == "some name"
    end

    test "create_groups/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MyGroup.create_groups(@invalid_attrs)
    end

    test "update_groups/2 with valid data updates the groups" do
      groups = groups_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Groups{} = groups} = MyGroup.update_groups(groups, update_attrs)
      assert groups.name == "some updated name"
    end

    test "update_groups/2 with invalid data returns error changeset" do
      groups = groups_fixture()
      assert {:error, %Ecto.Changeset{}} = MyGroup.update_groups(groups, @invalid_attrs)
      assert groups == MyGroup.get_groups!(groups.id)
    end

    test "delete_groups/1 deletes the groups" do
      groups = groups_fixture()
      assert {:ok, %Groups{}} = MyGroup.delete_groups(groups)
      assert_raise Ecto.NoResultsError, fn -> MyGroup.get_groups!(groups.id) end
    end

    test "change_groups/1 returns a groups changeset" do
      groups = groups_fixture()
      assert %Ecto.Changeset{} = MyGroup.change_groups(groups)
    end
  end

  describe "group_user" do
    alias EmailsApp.MyGroup.Group_users

    import EmailsApp.MyGroupFixtures

    @invalid_attrs %{}

    test "list_group_user/0 returns all group_user" do
      group_users = group_users_fixture()
      assert MyGroup.list_group_user() == [group_users]
    end

    test "get_group_users!/1 returns the group_users with given id" do
      group_users = group_users_fixture()
      assert MyGroup.get_group_users!(group_users.id) == group_users
    end

    test "create_group_users/1 with valid data creates a group_users" do
      valid_attrs = %{}

      assert {:ok, %Group_users{} = group_users} = MyGroup.create_group_users(valid_attrs)
    end

    test "create_group_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MyGroup.create_group_users(@invalid_attrs)
    end

    test "update_group_users/2 with valid data updates the group_users" do
      group_users = group_users_fixture()
      update_attrs = %{}

      assert {:ok, %Group_users{} = group_users} = MyGroup.update_group_users(group_users, update_attrs)
    end

    test "update_group_users/2 with invalid data returns error changeset" do
      group_users = group_users_fixture()
      assert {:error, %Ecto.Changeset{}} = MyGroup.update_group_users(group_users, @invalid_attrs)
      assert group_users == MyGroup.get_group_users!(group_users.id)
    end

    test "delete_group_users/1 deletes the group_users" do
      group_users = group_users_fixture()
      assert {:ok, %Group_users{}} = MyGroup.delete_group_users(group_users)
      assert_raise Ecto.NoResultsError, fn -> MyGroup.get_group_users!(group_users.id) end
    end

    test "change_group_users/1 returns a group_users changeset" do
      group_users = group_users_fixture()
      assert %Ecto.Changeset{} = MyGroup.change_group_users(group_users)
    end
  end
end
