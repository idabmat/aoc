defmodule Day1 do
  defstruct [
    mode: :silver,
    input_file: "lib/day1/input.txt"
  ]

  def execute(%{input_file: input_file, mode: mode}) do
    input_file
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> sample(3, mode)
    |> count()
  end

  defp sample(data, count, :gold) do
    data
    |> replicate(count)
    |> Enum.reduce(fn data, sum ->
      Enum.zip_with(data, sum, &(&1 + &2))
    end)
  end

  defp sample(data, _count, _mode), do: data

  defp replicate(list, 1), do: [list]

  defp replicate([_head | tail] = list, size) do
    [list | replicate(tail, size - 1)]
  end

  defp count(measurements) do
    initial = {0, List.first(measurements)}
    {counter, _} = Enum.reduce(measurements, initial, fn
      measure, {counter, last_measure} when measure > last_measure ->
        {counter + 1, measure}
      measure, {counter, _} ->
        {counter, measure}
    end)
    counter
  end

  defimpl Aoc do
    defdelegate execute(struct), to: Day1
  end
end
