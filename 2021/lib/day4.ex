defmodule Day4 do
  defstruct [
    input_file: "lib/day4/input.txt",
    mode: :silver
  ]

  defmodule Board do
    defstruct [
      draw: [],
      rows: [],
      columns: []
    ]

    def won?(%Board{rows: rows, columns: columns, draw: draw}) do
      rows ++ columns |> Enum.any?(fn row -> Enum.all?(row, fn number -> Enum.member?(draw, number) end) end)
    end
  end

  def execute(%{input_file: input_file}) do
    [raw_draw | raw_boards] =
      input_file
      |> File.read!
      |> String.split("\n", trim: true)

    boards =
      raw_boards
      |> Enum.chunk_every(5)
      |> Enum.map(&build_board/1)

    draw =
      raw_draw
      |> String.split(",", trim: true)

    pick_winner(draw, boards)
    |> score
  end

  defp build_board(raw_board) do
    rows = raw_board |> Enum.map(&String.split(&1, " ", trim: true))
    columns = rows |> Enum.zip() |> Enum.map(&Tuple.to_list/1)

    %Board{rows: rows, columns: columns}
  end

  defp pick_winner([], [winning_board]),  do: winning_board
  defp pick_winner([current_draw | remaining_draw], boards) do
    updated_boards = Enum.map(boards, fn board -> %Board{board | draw: board.draw ++ [current_draw]} end)
    case Enum.find(updated_boards, fn board -> Board.won?(board) end) do
      nil -> pick_winner(remaining_draw, updated_boards)
      winning_board -> pick_winner([], [winning_board])
    end
  end

  defp score(%Board{draw: draw, rows: rows}) do
    rows
    |> Enum.reduce(fn row, numbers -> numbers ++ row end)
    |> Enum.filter(fn number -> !Enum.member?(draw, number) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
    |> Kernel.*(draw |> List.last() |> String.to_integer())
  end

  defimpl Aoc do
    defdelegate execute(struct), to: Day4
  end
end
