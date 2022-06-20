defmodule MorkBorg.WorldFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorkBorg.World` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> MorkBorg.World.create_location()

    location
  end

  @doc """
  Generate a locale.
  """
  def locale_fixture(attrs \\ %{}) do
    {:ok, locale} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> MorkBorg.World.create_locale()

    locale
  end
end
