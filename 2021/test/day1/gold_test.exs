defmodule Day1.GoldTest do
  use ExUnit.Case, async: true

  alias Day1.Gold

  test "it uses sampling" do
    assert Gold.execute("test/day1/input.txt") == 5
  end
end
