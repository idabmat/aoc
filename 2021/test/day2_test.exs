defmodule Day2Test do
  use ExUnit.Case, async: true

  test "calculates new sub position" do
    day = %Day2{input_file: "test/day2/input.txt"}
    assert Aoc.execute(day) == 150
  end

  test "calculates new sub position with aim" do
    day = %Day2{input_file: "test/day2/input.txt", mode: :gold}
    assert Aoc.execute(day) == 900
  end
end
