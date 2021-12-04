defmodule Chapter1.MainTest do
  use ExUnit.Case, async: true

  alias Chapter1, as: Main

  test "it detects the number of depth increases" do
    assert Main.exec("test/chapter1/input.txt") == 7
  end
end
