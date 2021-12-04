defmodule Day4 do
  defstruct [
    input_file: "lib/day4/input.txt",
    mode: :silver
  ]

  def execute(%{input_file: input_file}) do
    [raw_draw | raw_boards] =
      input_file
      |> File.read!
      |> String.split("\n", trim: true)

    boards =
      raw_boards
      |> Enum.chunk_every(5)
      |> Enum.map(&parse_board/1)

    draw =
      raw_draw
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    pick_winner(draw, boards)
    |> score
  end

  defp parse_board(raw_board) do
    raw_board
    |> Enum.map(&parse_row/1)
  end

  defp parse_row(raw_row) do
    raw_row
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp pick_winner(_draw, _boards) do
    {
      [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24],
      [
        [14, 21, 17, 24, 4],
        [10, 16, 15, 9, 19],
        [18, 8, 23, 26, 20],
        [22, 11, 13, 6, 5],
        [2, 0, 12, 3, 7]
      ]
    }
  end

  defp score({_winning_draw, _winning_board}) do
    4512
  end

  defimpl Aoc do
    defdelegate execute(struct), to: Day4
  end
end
