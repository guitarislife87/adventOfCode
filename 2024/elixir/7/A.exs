defmodule A do
  def solve operands, operators, total do
    cond do
      length(operands) == 1 -> hd(operands) == total
      true -> solve([ hd(hd(operators)).(hd(operands), hd(tl(operands)))] ++ tl(tl(operands)), tl(operators), total) ||
              solve([ hd(tl(hd(operators))).(hd(operands), hd(tl(operands)))] ++  tl(tl(operands)), tl(operators), total)
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
|> Enum.map(fn x ->
  [sum, operands] = String.split(x, ":")
  {String.to_integer(sum), String.split(String.trim(operands), " ") |> Enum.map(&String.to_integer/1)}
end)
|> Enum.filter(fn {sum, operands} ->
  operators = Enum.map(0..length(operands)-2, fn _x -> [&*/2,&+/2] end)
  A.solve(operands, operators, sum)
end)
|> Enum.map(fn {sum, _} -> sum end)
|> Enum.sum()
|> IO.puts()
