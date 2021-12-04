defmodule Day3Test do
  use ExUnit.Case, async: true

  test "calculates the power consumption" do
    day = %Day3{input_file: "test/day3/input.txt"}
    assert Aoc.execute(day) == 198
  end
end
