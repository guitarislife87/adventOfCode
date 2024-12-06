"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
|> String.split("\n")
|> Enum.map(fn a -> String.split(a, "") end)
|> (fn xs ->
  Enum.map(0..(length(xs) - 1), fn i ->
    x = Enum.at(xs, i)
    Enum.map(0..(length(x) - 1), fn j ->
      pos = Enum.at(x, j)
      case pos do
        "X" ->
          surrounding = for di <- -3..3, dj <- -3..3, into: [], do: Enum.at(Enum.at(xs, i + di, []), j + dj, :none)
          count = 0
          # Left
          count = cond
            [_,_,_,["S","A","M","X"],_,_,_] in surrounding -> count + 1
            true -> count
          # Right
          count = cond
            [_,_,_,[_,_,_,"X","M","A","S"],_,_,_] in surrounding -> count + 1
            true -> count
          # Up
          count = cond
            [[_,_,_,"S"],[_,_,_,"A"],[_,_,_,"M"],[_,_,_,"X"],_,_,_] in surrounding -> count + 1
            true -> count
          # Down
          count = cond
            [_,_,_,[_,_,_,"X"],[_,_,_,"M"],[_,_,_,"A"],[_,_,_,"S"]] in surrounding -> count + 1
            true -> count
          # Diagonal Up Left
          count = cond
            [["S"],[_,"A"],[_,_,"M"],[_,_,_,"X"],_,_,_] in surrounding -> count + 1
            true -> count
          # Diagonal Down Left
          count = cond
            [_,_,_,[_,_,_,"X"],[_,_,"M"],[_,"A"],["S"]] in surrounding -> count + 1
            true -> count
          # Diagonal Up Right
          count = cond
            [[_,_,_,_,_,_,"S"],[_,_,_,_,_,"A"],[_,_,_,_,"M"],[_,_,_,"X"]] in surrounding -> count + 1
            true -> count
          # Diagonal Down Right
          count = cond
            [_,_,_,[_,_,_,"X"],[_,_,_,_,"M"],[_,_,_,_,_,"A"],[_,_,_,_,_,_,"S"]] in surrounding -> count + 1
            true -> count
        _ -> 0
      end
    end) |> Enum.sum()
  end) |> Enum.sum()
end).()
|> IO.puts()
