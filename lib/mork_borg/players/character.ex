defmodule MorkBorg.Players.Character do
  use Ecto.Schema
  import Ecto.Changeset

  alias MorkBorg.Inventory.Item
  alias MorkBorg.Inventory.Armor
  alias MorkBorg.Inventory.Weapon
  alias MorkBorg.World.Location

  schema "characters" do
    field :agility, :integer
    field :description, :string
    field :hit_points_current, :integer
    field :hit_points_max, :integer
    field :name, :string
    field :omens, :integer
    field :presence, :integer
    field :strength, :integer
    field :toughness, :integer

    has_many :weapons, Weapon
    has_many :items, Item
    has_one :armor, Armor

    belongs_to :location, Location

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [
      :name,
      :description,
      :hit_points_current,
      :hit_points_max,
      :strength,
      :agility,
      :presence,
      :toughness,
      :omens
    ])
    |> validate_required([
      :name,
      :hit_points_current,
      :hit_points_max,
      :strength,
      :agility,
      :presence,
      :toughness,
      :omens
    ])
  end
end
