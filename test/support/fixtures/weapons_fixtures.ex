defmodule MorkBorg.WeaponsFixtures do
  alias MorkBorg.Weapons

  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorkBorg.Weapons` context.
  """

  @doc """
  Generate a weapon.
  """
  def weapon_fixture(attrs \\ %{}) do
    {:ok, weapon} =
      attrs
      |> Enum.into(%{
        damage: 42,
        description: "some description",
        name: "some name"
      })
      |> Weapons.create_weapon()

    weapon
  end

  def weapon_fixture_for_chatacter(char) do
    Weapons.give_starter_weapon_to_character(char)
  end
end
