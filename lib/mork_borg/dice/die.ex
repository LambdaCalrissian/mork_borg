defmodule MorkBorg.Dice.Die do
  use Ecto.Schema
  alias MorkBorg.Dice.Die

  embedded_schema do
    field :sides, :integer
  end

  def roll(%Die{sides: sides}) do
    :rand.uniform(sides)
  end
end
