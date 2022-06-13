defmodule MorkBorg.Weapons.Weapon do
  use Ecto.Schema
  import Ecto.Changeset

  alias MorkBorg.Players.Character

  schema "weapons" do
    field :damage, :integer
    field :description, :string
    field :name, :string

    belongs_to :character, Character

    timestamps()
  end

  @doc false
  def changeset(weapon, attrs) do
    weapon
    |> cast(attrs, [:name, :description, :damage])
    |> validate_required([:name, :damage])
  end
end
