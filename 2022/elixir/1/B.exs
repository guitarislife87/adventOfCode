defmodule AdventOfCode do
  def solve(value, {curr, results}) do
    if value == "" do
      {0, results ++ [curr]}
    else
      {curr + String.to_integer(value), results}
    end
  end
end

"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
|> String.split("\n")
|> List.foldl({0, []}, fn line, {curr, max} ->
  AdventOfCode.solve(line, {curr, max})
end)
|> elem(1)
|> Enum.sort()
|> Enum.reverse()
|> Enum.take(3)
|> Enum.sum()
|> IO.inspect()
