defmodule MorkBorg.PlayersTest do
  use MorkBorg.DataCase

  alias MorkBorg.Players

  describe "characters" do
    alias MorkBorg.Players.Character

    import MorkBorg.PlayersFixtures
    import MorkBorg.WeaponsFixtures

    @invalid_attrs %{
      agility: nil,
      description: nil,
      hit_points_current: nil,
      hit_points_max: nil,
      name: nil,
      omens: nil,
      presence: nil,
      strength: nil,
      toughness: nil
    }

    test "list_characters/0 returns all characters" do
      character = character_fixture()
      assert Players.list_characters() == [character]
    end

    test "get_character!/1 returns the character with given id" do
      character = %{character_fixture() | weapons: [], items: []}
      assert Players.get_character!(character.id) == character
    end

    test "get_character!/1 returns the character with weapon" do
      character = character_fixture()
      weapon = weapon_fixture_for_chatacter(character)

      assert Players.get_character!(character.id).weapons == [weapon]
    end

    test "create_character/1 with valid data creates a character" do
      valid_attrs = %{
        agility: 42,
        description: "some description",
        hit_points_current: 42,
        hit_points_max: 42,
        name: "some name",
        omens: 42,
        presence: 42,
        strength: 42,
        toughness: 42
      }

      assert {:ok, %Character{} = character} = Players.create_character(valid_attrs)
      assert character.agility == 42
      assert character.description == "some description"
      assert character.hit_points_current == 42
      assert character.hit_points_max == 42
      assert character.name == "some name"
      assert character.omens == 42
      assert character.presence == 42
      assert character.strength == 42
      assert character.toughness == 42
    end

    test "create_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Players.create_character(@invalid_attrs)
    end

    test "update_character/2 with valid data updates the character" do
      character = character_fixture()

      update_attrs = %{
        agility: 43,
        description: "some updated description",
        hit_points_current: 43,
        hit_points_max: 43,
        name: "some updated name",
        omens: 43,
        presence: 43,
        strength: 43,
        toughness: 43
      }

      assert {:ok, %Character{} = character} = Players.update_character(character, update_attrs)
      assert character.agility == 43
      assert character.description == "some updated description"
      assert character.hit_points_current == 43
      assert character.hit_points_max == 43
      assert character.name == "some updated name"
      assert character.omens == 43
      assert character.presence == 43
      assert character.strength == 43
      assert character.toughness == 43
    end

    test "update_character/2 with invalid data returns error changeset" do
      character = %{character_fixture() | weapons: [], items: []}
      assert {:error, %Ecto.Changeset{}} = Players.update_character(character, @invalid_attrs)
      assert character == Players.get_character!(character.id)
    end

    test "delete_character/1 deletes the character" do
      character = character_fixture()
      assert {:ok, %Character{}} = Players.delete_character(character)
      assert_raise Ecto.NoResultsError, fn -> Players.get_character!(character.id) end
    end

    test "change_character/1 returns a character changeset" do
      character = character_fixture()
      assert %Ecto.Changeset{} = Players.change_character(character)
    end
  end
end
