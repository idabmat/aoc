defmodule Day3 do
  defstruct [
    input_file: "lib/day3/input.txt",
    mode: :silver
  ]

  def execute(%{input_file: input_file, mode: mode}) do
    input_file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(&String.codepoints/1)
    |> read_diagnostic(mode)
  end

  defp read_diagnostic(_diagnostic, :gold) do
    calculate_life_support_rating(%{o2: "10111", co2: "01010"})
  end

  defp read_diagnostic(diagnostic, _) do
    diagnostic
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

  defp calculate_power_consumption(%{gamma: gamma, epsilon: epsilon}), do: present([gamma, epsilon])

  defp calculate_life_support_rating(%{o2: o2, co2: co2}), do: present([o2, co2])

  defp present(ratings), do: ratings |> Enum.map(&binary_to_decimal/1) |> Enum.product()

  defp binary_to_decimal(binary), do: binary |> Integer.parse(2) |> elem(0)

  defimpl Aoc do
    defdelegate execute(struct), to: Day3
  end
end
