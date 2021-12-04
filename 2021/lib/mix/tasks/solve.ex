defmodule Mix.Tasks.Solve do
  use Mix.Task

  @shortdoc "Solves the puzzle for the given day/mode"

  @moduledoc """
  Solves the puzzle for the given day and mode.
  Pass in the number of the day and the mode (silver/gold)

  # Usage
  
  ```
  mix solve 1 silver
  ```
  """

  def run([day_number]), do: run([day_number, "silver"])
  def run([day_number, mode_name]) do
    mode = String.to_atom(mode_name)

    "Elixir.Day#{day_number}"
    |> String.to_existing_atom()
    |> struct(mode: mode)
    |> Aoc.execute()
    |> IO.puts()
  end
end
