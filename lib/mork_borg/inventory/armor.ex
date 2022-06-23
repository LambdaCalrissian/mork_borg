defmodule MorkBorg.Inventory.Armor do
  use Ecto.Schema
  import Ecto.Changeset

  alias MorkBorg.Players.Character
  alias MorkBorg.World.Location

  schema "armor" do
    field :description, :string
    field :name, :string
    field :current_tier, :integer, default: 0
    field :max_tier, :integer, default: 0
    belongs_to :character, Character
    belongs_to :location, Location

    timestamps()
  end

  @doc false
  def changeset(armor, attrs) do
    armor
    |> cast(attrs, [:name, :description, :max_tier, :current_tier])
    |> validate_required([:name, :current_tier, :max_tier])
    |> then(fn c ->
      validate_number(c, :current_tier, less_than_or_equal_to: get_field(c, :current_tier, 0))
    end)
  end
end
