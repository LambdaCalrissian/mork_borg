defmodule MorkBorg.World.Location do
  use Ecto.Schema
  import Ecto.Changeset

  alias MorkBorg.World.Location
  alias MorkBorg.World.Locale

  schema "locations" do
    field :description, :string
    field :name, :string
    has_many :adjoins, Location
    belongs_to :locale, Locale

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
