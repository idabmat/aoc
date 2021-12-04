defmodule Day2 do
  defstruct [
    mode: :silver,
    input_file: "lib/day2/input.txt"
  ]

  def execute(%{input_file: input_file, mode: mode}) do
    input_file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> move(mode)
    |> present()
  end

  defp move(moves, :gold) do
    initial = %{horizontal: 0, depth: 0, aim: 0}
    Enum.reduce(moves, initial, fn move, %{horizontal: horizontal, depth: depth, aim: aim} ->
      case move do
        "forward " <> forward ->
          %{horizontal: horizontal + String.to_integer(forward), depth: depth + aim * String.to_integer(forward), aim: aim}
        "down " <> down ->
          %{horizontal: horizontal, depth: depth, aim: aim + String.to_integer(down)}
        "up " <> up ->
          %{horizontal: horizontal, depth: depth, aim: aim - String.to_integer(up)}
      end
    end)
  end

  defp move(moves, _) do
    initial = %{horizontal: 0, depth: 0}
    Enum.reduce(moves, initial, fn move, %{horizontal: horizontal, depth: depth} ->
      case move do
        "forward " <> forward ->
          %{horizontal: horizontal + String.to_integer(forward), depth: depth}
        "down " <> down ->
          %{horizontal: horizontal, depth: depth + String.to_integer(down)}
        "up " <> up ->
          %{horizontal: horizontal, depth: depth - String.to_integer(up)}
      end
    end)
  end

  defp present(%{horizontal: horizontal, depth: depth}), do: horizontal * depth

  defimpl Aoc do
    defdelegate execute(struct), to: Day2
  end
end
