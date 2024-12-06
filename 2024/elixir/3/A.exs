"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
|> fn a -> Regex.scan(~r/mul\((\d+),(\d+)\)/, a) end.()
|> Enum.map(fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end)
|> Enum.sum()
|> IO.puts()
