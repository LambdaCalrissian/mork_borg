defmodule MorkBorg.Inventory.Weapon do
  use Ecto.Schema
  import Ecto.Changeset

  alias MorkBorg.Players.Character
  alias MorkBorg.World.Location

  schema "weapons" do
    field :damage, :integer
    field :description, :string
    field :name, :string

    belongs_to :character, Character
    belongs_to :location, Location

    timestamps()
  end

  @doc false
  def changeset(weapon, attrs) do
    weapon
    |> cast(attrs, [:name, :description, :damage])
    |> validate_required([:name, :damage])
  end
end
