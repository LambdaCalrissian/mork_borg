defmodule MorkBorg.DiceTest do
  use MorkBorg.DataCase

  alias MorkBorg.Dice

  describe "dice" do
    test "roll/1 returns a number x such that 1<=x<=sides" do
      res = Dice.roll(20)

      assert 1 <= res and res <= 20
    end
  end
end
