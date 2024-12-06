"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
|> String.split("\n")
|> Enum.map(fn line ->
  nums = line |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)
  Enum.zip(nums, tl(nums))
end)
|> Enum.filter(fn a -> Enum.all?(a, fn {x, y} -> x < y end) or Enum.all?(a, fn {x, y} -> x > y end) end)
|> Enum.filter(fn a -> Enum.all?(a, fn {x, y} -> abs(y - x) < 4 end) end)
|> Enum.count()
|> IO.puts()
