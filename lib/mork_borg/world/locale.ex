defmodule MorkBorg.World.Locale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locales" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(locale, attrs) do
    locale
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
