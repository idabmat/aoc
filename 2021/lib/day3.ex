defmodule Day3 do
  defstruct [
    input_file: "lib/day3/input.txt",
    mode: :silver
  ]

  def execute(%{input_file: input_file}) do
    input_file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&String.codepoints/1)
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(&Enum.frequencies/1)
    |> extract_gamma_and_epsilon_rate()
    |> calculate_power_consumption()
  end

  defp extract_gamma_and_epsilon_rate(frequencies) do
    initial = %{gamma: "", epsilon: ""}
    Enum.reduce(frequencies, initial, fn
      %{"0" => zeros, "1" => ones}, %{gamma: gamma, epsilon: epsilon} when zeros > ones ->
        %{
          gamma: gamma <> "0",
          epsilon: epsilon <> "1"
        }
      _, %{gamma: gamma, epsilon: epsilon} ->
        %{
          gamma: gamma <> "1",
          epsilon: epsilon <> "0"
        }
    end)
  end

  defp calculate_power_consumption(%{epsilon: epsilon, gamma: gamma})  do
    binary_to_decimal(epsilon) * binary_to_decimal(gamma)
  end

  defp binary_to_decimal(binary) do
    binary |> Integer.parse(2) |> elem(0)
  end

  defimpl Aoc do
    defdelegate execute(struct), to: Day3
  end
end
