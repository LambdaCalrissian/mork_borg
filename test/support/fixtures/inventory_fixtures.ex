defmodule MorkBorg.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorkBorg.Inventory` context.
  """

  alias MorkBorg.Players.Character

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        action: "some action",
        count: 42,
        description: "some description",
        name: "some name"
      })
      |> MorkBorg.Inventory.create_item()

    item
  end

  def item_fixture_for_character(%Character{} = char) do
    MorkBorg.Inventory.give_starting_items_to_character(char)
  end

  @doc """
  Generate a armor.
  """
  def armor_fixture(attrs \\ %{}) do
    {:ok, armor} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        max_tier: 42,
        current_tier: 42
      })
      |> MorkBorg.Inventory.create_armor()

    armor
  end

  def armor_fixture_for_character(%Character{} = char) do
    MorkBorg.Inventory.give_starting_armor_to_character(char)
  end
end
