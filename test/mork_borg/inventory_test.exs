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
      valid_attrs = %{
        action: "some action",
        count: 42,
        description: "some description",
        name: "some name"
      }

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

      update_attrs = %{
        action: "some updated action",
        count: 43,
        description: "some updated description",
        name: "some updated name"
      }

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

  describe "armor" do
    alias MorkBorg.Inventory.Armor

    import MorkBorg.InventoryFixtures

    @invalid_attrs %{description: nil, name: nil, tier: nil}

    test "list_armor/0 returns all armor" do
      armor = armor_fixture()
      assert Inventory.list_armor() == [armor]
    end

    test "get_armor!/1 returns the armor with given id" do
      armor = armor_fixture()
      assert Inventory.get_armor!(armor.id) == armor
    end

    test "create_armor/1 with valid data creates a armor" do
      valid_attrs = %{description: "some description", name: "some name", current_tier: 42, max_tier: 42}

      assert {:ok, %Armor{} = armor} = Inventory.create_armor(valid_attrs)
      assert armor.description == "some description"
      assert armor.name == "some name"
      assert armor.current_tier == 42
      assert armor.max_tier == 42
    end

    test "create_armor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_armor(@invalid_attrs)
    end

    test "update_armor/2 with valid data updates the armor" do
      armor = armor_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", current_tier: 43, max_tier: 43}

      assert {:ok, %Armor{} = armor} = Inventory.update_armor(armor, update_attrs)
      assert armor.description == "some updated description"
      assert armor.name == "some updated name"
      assert armor.current_tier== 43
      assert armor.max_tier== 43
    end

    test "update_armor/2 with invalid data returns error changeset" do
      armor = armor_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_armor(armor, @invalid_attrs)
      assert armor == Inventory.get_armor!(armor.id)
    end

    test "delete_armor/1 deletes the armor" do
      armor = armor_fixture()
      assert {:ok, %Armor{}} = Inventory.delete_armor(armor)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_armor!(armor.id) end
    end

    test "change_armor/1 returns a armor changeset" do
      armor = armor_fixture()
      assert %Ecto.Changeset{} = Inventory.change_armor(armor)
    end
  end
end
