defmodule MorkBorg.WeaponsTest do
  use MorkBorg.DataCase

  alias MorkBorg.Weapons

  describe "weapons" do
    alias MorkBorg.Weapons.Weapon

    import MorkBorg.WeaponsFixtures

    @invalid_attrs %{damage: nil, description: nil, name: nil}

    test "list_weapons/0 returns all weapons" do
      weapon = weapon_fixture()
      assert Weapons.list_weapons() == [weapon]
    end

    test "get_weapon!/1 returns the weapon with given id" do
      weapon = weapon_fixture()
      assert Weapons.get_weapon!(weapon.id) == weapon
    end

    test "create_weapon/1 with valid data creates a weapon" do
      valid_attrs = %{damage: 42, description: "some description", name: "some name"}

      assert {:ok, %Weapon{} = weapon} = Weapons.create_weapon(valid_attrs)
      assert weapon.damage == 42
      assert weapon.description == "some description"
      assert weapon.name == "some name"
    end

    test "create_weapon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weapons.create_weapon(@invalid_attrs)
    end

    test "update_weapon/2 with valid data updates the weapon" do
      weapon = weapon_fixture()
      update_attrs = %{damage: 43, description: "some updated description", name: "some updated name"}

      assert {:ok, %Weapon{} = weapon} = Weapons.update_weapon(weapon, update_attrs)
      assert weapon.damage == 43
      assert weapon.description == "some updated description"
      assert weapon.name == "some updated name"
    end

    test "update_weapon/2 with invalid data returns error changeset" do
      weapon = weapon_fixture()
      assert {:error, %Ecto.Changeset{}} = Weapons.update_weapon(weapon, @invalid_attrs)
      assert weapon == Weapons.get_weapon!(weapon.id)
    end

    test "delete_weapon/1 deletes the weapon" do
      weapon = weapon_fixture()
      assert {:ok, %Weapon{}} = Weapons.delete_weapon(weapon)
      assert_raise Ecto.NoResultsError, fn -> Weapons.get_weapon!(weapon.id) end
    end

    test "change_weapon/1 returns a weapon changeset" do
      weapon = weapon_fixture()
      assert %Ecto.Changeset{} = Weapons.change_weapon(weapon)
    end
  end
end
