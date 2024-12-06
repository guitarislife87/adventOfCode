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
            surrounding = Enum.reduce(-3..3, [], fn di, acc ->
              row = Enum.reduce(-3..3, [], fn dj, row_acc ->
                cond do
                  i + di < 0 -> [:nil | row_acc]
                  j + dj < 0 -> [:nil | row_acc]
                  i + di >= length(xs) -> [:nil | row_acc]
                  j + dj >= length(Enum.at(xs, i + di, [])) -> [:nil | row_acc]
                  true -> [Enum.at(Enum.at(xs, i + di, []), j + dj, :nil) | row_acc]
                end
              end) |> Enum.reverse()
              [row | acc]
            end) |> Enum.reverse()
          IO.inspect(surrounding)
          count = 0
          # Left
          count = case surrounding do
             [
               [ _ , _ , _ , _ , _ , _ ,_ ],
               [ _ , _ , _ , _ , _ , _ ,_ ],
               [ _ , _ , _ , _ , _ , _ ,_ ],
               ["S","A","M","X", _ , _ ,_ ],
               [ _ , _ , _ , _ , _ , _ ,_ ],
               [ _ , _ , _ , _ , _ , _ ,_ ],
               [ _ , _ , _ , _ , _ , _ ,_ ]
             ] -> count + 1
             _ -> count
          end
          # Right
          count = case surrounding do
            [
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ ,"X","M","A","S"],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ]
            ] -> count + 1
            _ -> count
            end
          # Up
          count = case surrounding do
            [
              [ _ , _ , _ ,"S", _ , _ , _ ],
              [ _ , _ , _ ,"A", _ , _ , _ ],
              [ _ , _ , _ ,"M", _ , _ , _ ],
              [ _ , _ , _ ,"X", _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ]
            ] -> count + 1
            _ -> count
          end
          # Down
          count = case surrounding do
            [
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ ,"X", _ , _ , _ ],
              [ _ , _ , _ ,"M", _ , _ , _ ],
              [ _ , _ , _ ,"A", _ , _ , _ ],
              [ _ , _ , _ ,"S", _ , _ , _ ]
            ] -> count + 1
            _ -> count
            end
          # Diagonal Up Left
          count = case surrounding do
            [
              ["S", _ , _ , _ , _ , _ , _ ],
              [ _ ,"A", _ , _ , _ , _ , _ ],
              [ _ , _ ,"M", _ , _ , _ , _ ],
              [ _ , _ , _ ,"X", _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ]
            ] -> count + 1
            _ -> count
          end
          # Diagonal Up Right
          count = case surrounding do
            [
              [ _ , _ , _ , _ , _ , _ ,"S"],
              [ _ , _ , _ , _ , _ ,"A", _ ],
              [ _ , _ , _ , _ ,"M", _ , _ ],
              [ _ , _ , _ ,"X", _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ]
            ] -> count + 1
            _ -> count
          end
          # Diagonal Down Left
          count = case surrounding do
            [
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ ,"X", _ , _ , _ ],
              [ _ , _ ,"M", _ , _ , _ , _ ],
              [ _ ,"A", _ , _ , _ , _ , _ ],
              ["S", _ , _ , _ , _ , _ , _ ]
            ] -> count + 1
            _ -> count
            end
          # Diagonal Down Right
          count = case surrounding do
            [
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ , _ , _ , _ , _ ],
              [ _ , _ , _ ,"X", _ , _ , _ ],
              [ _ , _ , _ , _ ,"M", _ , _ ],
              [ _ , _ , _ , _ , _ ,"A", _ ],
              [ _ , _ , _ , _ , _ , _ ,"S"]
            ] -> count + 1
            _ -> count
            end
          IO.inspect(count)
          count
        _ -> 0
      end
    end) |> Enum.sum()
  end) |> Enum.sum()
end).()
|> IO.puts()
