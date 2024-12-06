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
        "A" ->
          cond do
            j == 0 -> 0
            j == (length(x) - 1) -> 0
            i == 0 -> 0
            i == (length(xs) - 1) -> 0
            Enum.at(Enum.at(xs, i-1), j+1) == "M" and Enum.at(Enum.at(xs, i-1), j-1) == "M" and Enum.at(Enum.at(xs, i+1), j+1) == "S" and Enum.at(Enum.at(xs, i+1), j-1) == "S" -> 1
            Enum.at(Enum.at(xs, i-1), j+1) == "M" and Enum.at(Enum.at(xs, i+1), j+1) == "M" and Enum.at(Enum.at(xs, i-1), j-1) == "S" and Enum.at(Enum.at(xs, i+1), j-1) == "S" -> 1
            Enum.at(Enum.at(xs, i+1), j-1) == "M" and Enum.at(Enum.at(xs, i-1), j-1) == "M" and Enum.at(Enum.at(xs, i+1), j+1) == "S" and Enum.at(Enum.at(xs, i-1), j+1) == "S" -> 1
            Enum.at(Enum.at(xs, i+1), j-1) == "M" and Enum.at(Enum.at(xs, i+1), j+1) == "M" and Enum.at(Enum.at(xs, i-1), j-1) == "S" and Enum.at(Enum.at(xs, i-1), j+1) == "S" -> 1
            true -> 0
          end
        _ -> 0
      end
    end) |> Enum.sum()
  end) |> Enum.sum()
end).()
|> IO.puts()
