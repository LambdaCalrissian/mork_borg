defmodule MorkBorg.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorkBorg.Inventory` context.
  """

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
end
