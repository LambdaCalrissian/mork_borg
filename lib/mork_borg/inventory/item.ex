defmodule MorkBorg.Inventory.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias MorkBorg.Players.Character

  schema "items" do
    field :action, :string
    field :count, :integer, default: 1

    field :count_modifiers, {:array, Ecto.Enum},
      values: [:presence, :d4],
      default: [],
      virtual: true

    field :description, :string
    field :name, :string

    belongs_to :character, Character

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :count, :action])
    |> validate_required([:name])
  end
end
