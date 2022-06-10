defmodule MorkBorg.Dice do
  @moduledoc """
  The Dice context.
  """

  alias MorkBorg.Dice.Die

  def roll(sides) do
    %Die{sides: sides}
    |> Die.roll
  end
end
