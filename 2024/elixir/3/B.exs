"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
|> fn a -> Regex.scan(~r/mul\((\d+),(\d+)\)|(don't\(\))|(do\(\))/, a) end.()
|> Enum.reduce({0, true}, fn
  ["don't()", _, _, _], {acc, _} -> {acc, false}
  ["do()", _, _, _, _], {acc, _} -> {acc, true}
  [_, a, b], {acc, true} -> {acc + String.to_integer(a) * String.to_integer(b), true}
  [_, _, _], {acc, false} -> {acc, false}
end)
|> elem(0)
|> IO.puts()
