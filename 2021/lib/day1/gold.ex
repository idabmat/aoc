defmodule Day1.Gold do
  def execute(input_path) do
    input_path
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> replicate(3)
    |> Enum.reduce(fn data, sum ->
      Enum.zip_with(data, sum, &(&1 + &2))
    end)
    |> count()
  end

  defp replicate(list, 1) do
    [list]
  end

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
end
