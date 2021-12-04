defmodule Day1.Silver do
  @spec execute(String.t()) :: integer()
  def execute(input_path) do
    depths =
      input_path
      |> File.read!()
      |> String.split()
    
    {counter, _} = Enum.reduce(depths, {0, List.first(depths)}, &handle/2)
    counter
  end

  defp handle(depth, {counter, last_depth}) when depth >= last_depth do
    {counter + 1, depth}
  end
  defp handle(depth, {counter, _last_depth}) do
    {counter, depth}
  end
end
