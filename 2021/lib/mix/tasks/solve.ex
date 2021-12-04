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

  def run([day_number, mode_name]) when mode_name == "silver" or mode_name == "gold" do
    mode = String.capitalize(mode_name)
    module = String.to_existing_atom("Elixir.Day#{day_number}.#{mode}")
    input_path = "lib/day#{day_number}/input.txt"
    res = apply(module, :execute, [input_path])
    IO.puts(res)
  end
end
