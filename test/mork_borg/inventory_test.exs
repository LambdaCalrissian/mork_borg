defmodule MorkBorg.InventoryTest do
  use MorkBorg.DataCase

  alias MorkBorg.Inventory

  describe "item" do
    alias MorkBorg.Inventory.Item

    import MorkBorg.InventoryFixtures

    @invalid_attrs %{action: nil, count: nil, description: nil, name: nil}

    test "list_items/0 returns all item" do
      item = item_fixture()
      assert Inventory.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Inventory.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{action: "some action", count: 42, description: "some description", name: "some name"}

      assert {:ok, %Item{} = item} = Inventory.create_item(valid_attrs)
      assert item.action == "some action"
      assert item.count == 42
      assert item.description == "some description"
      assert item.name == "some name"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{action: "some updated action", count: 43, description: "some updated description", name: "some updated name"}

      assert {:ok, %Item{} = item} = Inventory.update_item(item, update_attrs)
      assert item.action == "some updated action"
      assert item.count == 43
      assert item.description == "some updated description"
      assert item.name == "some updated name"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_item(item, @invalid_attrs)
      assert item == Inventory.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Inventory.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Inventory.change_item(item)
    end
  end
end
