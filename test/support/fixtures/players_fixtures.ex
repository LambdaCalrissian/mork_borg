defmodule MorkBorg.PlayersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorkBorg.Players` context.
  """

  @doc """
  Generate a character.
  """
  def character_fixture(attrs \\ %{}) do
    {:ok, character} =
      attrs
      |> Enum.into(%{
        agility: 42,
        description: "some description",
        hit_points_current: 42,
        hit_points_max: 42,
        name: "some name",
        omens: 42,
        presence: 42,
        strength: 42,
        toughness: 42
      })
      |> MorkBorg.Players.create_character()

    character
  end
end
