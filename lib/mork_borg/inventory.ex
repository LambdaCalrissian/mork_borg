defmodule MorkBorg.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias MorkBorg.Repo

  alias MorkBorg.Dice
  alias MorkBorg.Inventory.Item
  alias MorkBorg.Inventory.Armor
  alias MorkBorg.Players.Character

  @starter_items_1 [
    nil,
    nil,
    %Item{
      name: "backpack",
      description: "for 7 normal-sized items"
    },
    %Item{
      name: "sack",
      description: "for 10 normal-sized items"
    },
    %Item{
      name: "small wagon"
    },
    %Item{
      name: "donkey",
      description: ", not bad"
    }
  ]

  @starter_items_2 [
    %Item{name: "rope", description: "30 feet"},
    %Item{name: "torches", count: 4, count_modifiers: [:presence]},
    %Item{
      name: "lantern",
      description: "with oil for Presence +6 hours",
      count: 6,
      count_modifiers: [:presence]
    },
    %Item{name: "magnesium strip"},
    %Item{name: "unclean scroll", description: "random"},
    %Item{name: "sharp needle"},
    %Item{
      name: "medicine chest",
      description: "Presence+4 uses (stops bleeding/infection and heals d6 HP)",
      count: 4,
      count_modifiers: [:presence]
    },
    %Item{name: "metal file and lockpicks"},
    %Item{name: "bear trap", description: "(Presence DR14 to spot, d8 damage)"},
    %Item{name: "bomb", description: "(sealed bottle, d10 damage)"},
    %Item{
      name: "red poison",
      description: "a bottle of d4 does (Toughness DR12 or d10 damage)",
      count: 0,
      count_modifiers: [:d4]
    },
    %Item{name: "silver crucifix"}
  ]

  @starter_items_3 [
    %Item{
      name: "life elixir",
      description: "d4 doses (heals d6 HP and removes infection)",
      count: 0,
      count_modifiers: [:d4]
    },
    %Item{name: "sacred scroll", description: "random"},
    %Item{
      name: "small but vicious dog",
      description: "(d6+2 HP, bite d4, only obeys you)"
    },
    %Item{
      name: "monkeys",
      description: "that ignore but love you(d4+2 HP, punch/bite d4)",
      count: 0,
      count_modifiers: [:d4]
    },
    %Item{name: "equisite perfume", description: "worth 25s"},
    %Item{name: "toolbox", description: "10 nails, tongs, hammer, small saw and drill"},
    %Item{name: "heavy chain", description: "15 feet"},
    %Item{name: "grappling hook"},
    %Item{
      name: "shield",
      description: "(-1HP damage or have the shield break to ignore 1 attack)"
    },
    %Item{name: "crowbar", description: "d4 damage"},
    %Item{name: "lard", description: "(may function as 5 meals in a pinch)"},
    %Item{name: "tent"}
  ]

  @starter_armor [
    %Armor{name: "no armor", current_tier: 0, max_tier: 0},
    %Armor{name: "light", description: "fur", current_tier: 1, max_tier: 1},
    %Armor{name: "medium", description: "mail", current_tier: 2, max_tier: 2},
    %Armor{name: "heavy", description: "plate", current_tier: 3, max_tier: 3}
  ]

  @doc """
  Returns the list of item.

  ## Examples

      iex> list_item()
      [%Item{}, ...]

  """
  def list_items do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  def give_starting_items_to_character(%Character{} = character) do
    [
      Enum.random(@starter_items_1),
      Enum.random(@starter_items_2),
      Enum.random(@starter_items_3)
    ]
    |> Enum.filter(fn item -> !is_nil(item) end)
    |> Enum.map(fn item ->
      give_item_to_character(item, character)
    end)
  end

  def give_item_to_character(%Item{} = item, %Character{} = character) do
    additional_count =
      Enum.reduce(item.count_modifiers, 0, fn key, acc ->
        case key do
          :d4 -> Dice.roll(4)
          :presence -> character.presence
        end

        +acc
      end)

    Ecto.build_assoc(character, :items, %{item | count: item.count + additional_count})
    |> Repo.insert!()
  end

  alias MorkBorg.Inventory.Armor

  @doc """
  Returns the list of armor.

  ## Examples

      iex> list_armor()
      [%Armor{}, ...]

  """
  def list_armor do
    Repo.all(Armor)
  end

  @doc """
  Gets a single armor.

  Raises `Ecto.NoResultsError` if the Armor does not exist.

  ## Examples

      iex> get_armor!(123)
      %Armor{}

      iex> get_armor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_armor!(id), do: Repo.get!(Armor, id)

  @doc """
  Creates a armor.

  ## Examples

      iex> create_armor(%{field: value})
      {:ok, %Armor{}}

      iex> create_armor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_armor(attrs \\ %{}) do
    %Armor{}
    |> Armor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a armor.

  ## Examples

      iex> update_armor(armor, %{field: new_value})
      {:ok, %Armor{}}

      iex> update_armor(armor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_armor(%Armor{} = armor, attrs) do
    armor
    |> Armor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a armor.

  ## Examples

      iex> delete_armor(armor)
      {:ok, %Armor{}}

      iex> delete_armor(armor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_armor(%Armor{} = armor) do
    Repo.delete(armor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking armor changes.

  ## Examples

      iex> change_armor(armor)
      %Ecto.Changeset{data: %Armor{}}

  """
  def change_armor(%Armor{} = armor, attrs \\ %{}) do
    Armor.changeset(armor, attrs)
  end

  def give_starting_armor_to_character(%Character{} = character) do
    # TODO only can get up to light armor if you have a scroll
    Ecto.build_assoc(character, :armor, Enum.random(@starter_armor))
    |> Repo.insert!()
  end
end
