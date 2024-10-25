defmodule AdventOfCode do
  def solve(value, {curr, max}) do
    if value == "" do
      if (curr > max) do
        {0, curr}
      else
        {0, max}
      end
    else
      {curr + String.to_integer(value), max}
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
|> List.foldl({0, 0}, fn line, {curr, max} ->
  AdventOfCode.solve(line, {curr, max})
end)
|> elem(1)
|> IO.inspect()
