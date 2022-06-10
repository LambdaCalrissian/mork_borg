defmodule MorkBorg.WeaponsFixtures do
  alias MorkBorg.Repo
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
      |> MorkBorg.Weapons.create_weapon()

    weapon
  end

  def weapon_fixture_for_chatacter(char) do
    Ecto.build_assoc(char, :weapons, %{damage: 42, description: "Sharp", name: "Swordius"})
    |> Repo.insert!()
  end
end
