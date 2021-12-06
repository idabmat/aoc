defmodule Day3 do
  defstruct [
    input_file: "lib/day3/input.txt",
    mode: :silver
  ]

  def solve(%{input_file: input_file, mode: mode}) do
    input_file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.codepoints/1)
    |> read_diagnostic(mode)
  end

  defp read_diagnostic(diagnostic, :gold) do
    diagnostic
    |> extract_o2_and_co2_rating()
    |> calculate_life_support_rating()
  end

  defp read_diagnostic(diagnostic, _) do
    diagnostic
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
    |> extract_gamma_and_epsilon_rate()
    |> calculate_power_consumption()
  end

  defp extract_o2_and_co2_rating(diagnostics) do
    %{
      o2: filter_ratings(diagnostics, 0, :o2),
      co2: filter_ratings(diagnostics, 0, :co2)
    }
  end

  defp filter_ratings([h], _, _), do: Enum.join(h)
  defp filter_ratings(diagnostics, counter, rating) do
    selected_bit =
      diagnostics
      |> Enum.map(&Enum.at(&1, counter))
      |> Enum.frequencies
      |> bit_criteria(rating)
    diagnostics
    |> Enum.filter(fn diagnostic ->
      Enum.at(diagnostic, counter) == selected_bit
    end)
    |> filter_ratings(counter + 1, rating)
  end

  defp bit_criteria(%{"0" => zeros, "1" => ones}, :o2) when zeros > ones, do: "0"
  defp bit_criteria(%{"0" => zeros, "1" => ones}, :co2) when zeros <= ones, do: "0"
  defp bit_criteria(_, _), do: "1"

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
    defdelegate solve(day), to: Day3
  end
end
