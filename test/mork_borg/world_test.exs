defmodule MorkBorg.WorldTest do
  use MorkBorg.DataCase

  alias MorkBorg.World

  describe "locations" do
    alias MorkBorg.World.Location

    import MorkBorg.WorldFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert World.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert World.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Location{} = location} = World.create_location(valid_attrs)
      assert location.description == "some description"
      assert location.name == "some name"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = World.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Location{} = location} = World.update_location(location, update_attrs)
      assert location.description == "some updated description"
      assert location.name == "some updated name"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = World.update_location(location, @invalid_attrs)
      assert location == World.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = World.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> World.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = World.change_location(location)
    end
  end

  describe "locales" do
    alias MorkBorg.World.Locale

    import MorkBorg.WorldFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_locales/0 returns all locales" do
      locale = locale_fixture()
      assert World.list_locales() == [locale]
    end

    test "get_locale!/1 returns the locale with given id" do
      locale = locale_fixture()
      assert World.get_locale!(locale.id) == locale
    end

    test "create_locale/1 with valid data creates a locale" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Locale{} = locale} = World.create_locale(valid_attrs)
      assert locale.description == "some description"
      assert locale.name == "some name"
    end

    test "create_locale/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = World.create_locale(@invalid_attrs)
    end

    test "update_locale/2 with valid data updates the locale" do
      locale = locale_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Locale{} = locale} = World.update_locale(locale, update_attrs)
      assert locale.description == "some updated description"
      assert locale.name == "some updated name"
    end

    test "update_locale/2 with invalid data returns error changeset" do
      locale = locale_fixture()
      assert {:error, %Ecto.Changeset{}} = World.update_locale(locale, @invalid_attrs)
      assert locale == World.get_locale!(locale.id)
    end

    test "delete_locale/1 deletes the locale" do
      locale = locale_fixture()
      assert {:ok, %Locale{}} = World.delete_locale(locale)
      assert_raise Ecto.NoResultsError, fn -> World.get_locale!(locale.id) end
    end

    test "change_locale/1 returns a locale changeset" do
      locale = locale_fixture()
      assert %Ecto.Changeset{} = World.change_locale(locale)
    end
  end
end
