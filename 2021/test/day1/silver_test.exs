defmodule Day1.SilverTest do
  use ExUnit.Case, async: true

  alias Day1.Silver

  test "it detects the number of depth increases" do
    assert Silver.execute("test/day1/input.txt") == 7
  end
end
