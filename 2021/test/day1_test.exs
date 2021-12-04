defmodule Day1Test do
  use ExUnit.Case, async: true

  test "detects the number of depth increases" do
    day = %Day1{input_file: "test/day1/input.txt"}
    assert Aoc.execute(day) == 7
  end

  test "uses sampling to determine depth increases" do
    day = %Day1{input_file: "test/day1/input.txt", mode: :gold}
    assert Aoc.execute(day) == 5
  end
end
