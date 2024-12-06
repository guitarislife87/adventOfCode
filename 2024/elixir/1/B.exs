"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
|> String.split("\n")
|> Enum.map(fn line ->
  [a, b] = String.split(line, "   ")
  {String.to_integer(a), String.to_integer(b)}
end)
|> Enum.reduce({[], []}, fn {a, b}, {list_a, list_b} ->
  {[a | list_a], [b | list_b]}
end)
|> (fn {list_a, list_b} -> {Enum.sort(list_a), Enum.frequencies(list_b)} end).()
|> (fn {list_a, counts_b} -> list_a |> Enum.map(fn item -> item * (counts_b[item] || 0) end) end).()
|> Enum.sum()
|> IO.puts()
