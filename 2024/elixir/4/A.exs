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
          count = 0
          count = if j > 2 and Enum.at(x, j-1) == "M" and Enum.at(x, j-2) == "A" and Enum.at(x, j-3) == "S", do: count + 1, else: count
          count = if j < (length(x) - 3) and Enum.at(x, j+1) == "M" and Enum.at(x, j+2) == "A" and Enum.at(x, j+3) == "S", do: count + 1, else: count
          count = if i > 2 and Enum.at(Enum.at(xs, i-1), j) == "M" and Enum.at(Enum.at(xs, i-2), j) == "A" and Enum.at(Enum.at(xs, i-3), j) == "S", do: count + 1, else: count
          count = if i < (length(xs) - 3) and Enum.at(Enum.at(xs, i+1), j) == "M" and Enum.at(Enum.at(xs, i+2), j) == "A" and Enum.at(Enum.at(xs, i+3), j) == "S", do: count + 1, else: count
          count = if j > 2 and i > 2 and Enum.at(Enum.at(xs, i-1), j-1) == "M" and Enum.at(Enum.at(xs, i-2), j-2) == "A" and Enum.at(Enum.at(xs, i-3), j-3) == "S", do: count + 1, else: count
          count = if j < (length(x) - 3) and i > 2 and Enum.at(Enum.at(xs, i-1), j+1) == "M" and Enum.at(Enum.at(xs, i-2), j+2) == "A" and Enum.at(Enum.at(xs, i-3), j+3) == "S", do: count + 1, else: count
          count = if j > 2 and i < (length(xs) - 3) and Enum.at(Enum.at(xs, i+1), j-1) == "M" and Enum.at(Enum.at(xs, i+2), j-2) == "A" and Enum.at(Enum.at(xs, i+3), j-3) == "S", do: count + 1, else: count
          count = if j < (length(x) - 3) and i < (length(xs) - 3) and Enum.at(Enum.at(xs, i+1), j+1) == "M" and Enum.at(Enum.at(xs, i+2), j+2) == "A" and Enum.at(Enum.at(xs, i+3), j+3) == "S", do: count + 1, else: count
          count
        _ -> 0
      end
    end) |> Enum.sum()
  end) |> Enum.sum()
end).()
|> IO.puts()
