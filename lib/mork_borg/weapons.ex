defmodule MorkBorg.Weapons do
  @moduledoc """
  The Weapons context.
  """

  import Ecto.Query, warn: false
  alias MorkBorg.Repo

  alias MorkBorg.Weapons.Weapon
  alias MorkBorg.Players.Character
  alias MorkBorg.Dice

  @starter_weapons %{
    1  => %Weapon{name: "Femur", damage: 4},
    2  => %Weapon{name: "Staff", damage: 4},
    3  => %Weapon{name: "Shortsword", damage: 4},
    4  => %Weapon{name: "Knife", damage: 4},
    5  => %Weapon{name: "Warhammer", damage: 6},
    6  => %Weapon{name: "Sword", damage: 6},
    7  => %Weapon{name: "Bow", damage: 6},
    8  => %Weapon{name: "Flail", damage: 8},
    9  => %Weapon{name: "Crossbow", damage: 8},
    10 => %Weapon{name: "Zweihander", damage: 10},
  }

  @doc """
  Returns the list of weapons.

  ## Examples

      iex> list_weapons()
      [%Weapon{}, ...]

  """
  def list_weapons do
    Repo.all(Weapon)
  end

  @doc """
  Gets a single weapon.

  Raises `Ecto.NoResultsError` if the Weapon does not exist.

  ## Examples

      iex> get_weapon!(123)
      %Weapon{}

      iex> get_weapon!(456)
      ** (Ecto.NoResultsError)

  """
  def get_weapon!(id), do: Repo.get!(Weapon, id)

  @doc """
  Creates a weapon.

  ## Examples

      iex> create_weapon(%{field: value})
      {:ok, %Weapon{}}

      iex> create_weapon(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_weapon(attrs \\ %{}) do
    %Weapon{}
    |> Weapon.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a weapon.

  ## Examples

      iex> update_weapon(weapon, %{field: new_value})
      {:ok, %Weapon{}}

      iex> update_weapon(weapon, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_weapon(%Weapon{} = weapon, attrs) do
    weapon
    |> Weapon.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a weapon.

  ## Examples

      iex> delete_weapon(weapon)
      {:ok, %Weapon{}}

      iex> delete_weapon(weapon)
      {:error, %Ecto.Changeset{}}

  """
  def delete_weapon(%Weapon{} = weapon) do
    Repo.delete(weapon)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking weapon changes.

  ## Examples

      iex> change_weapon(weapon)
      %Ecto.Changeset{data: %Weapon{}}

  """
  def change_weapon(%Weapon{} = weapon, attrs \\ %{}) do
    Weapon.changeset(weapon, attrs)
  end

  def pick_starter_weapon_for_character(%Character{} = _character \\ %Character{}) do
    Map.get(@starter_weapons, Dice.roll(10))
  end

  def give_starter_weapon_to_character(%Character{} = character) do
    Ecto.build_assoc(character, :weapons, pick_starter_weapon_for_character(character))
    |> Repo.insert!()
  end
end
