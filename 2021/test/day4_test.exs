defmodule Day4Test do
  use ExUnit.Case, async: true

  test "calculates the score of the winning board" do
    day = %Day4{input_file: "test/day4/input.txt"}
    assert Aoc.solve(day) == 4512
  end

  test "calculates the score of the last winning board" do
    day = %Day4{input_file: "test/day4/input.txt", mode: :gold}
    assert Aoc.solve(day) == 1924
  end
end
