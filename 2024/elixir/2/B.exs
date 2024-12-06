"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
|> String.split("\n")
|> Enum.map(fn line ->
  nums = line |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)
  Enum.reduce(0..length(nums) - 1, [], fn i, acc ->
    temp_nums = List.delete_at(nums, i)
    acc ++ [Enum.zip(temp_nums, tl(temp_nums))]
  end)
end)
|> IO.inspect()
|> Enum.filter(fn b ->
  Enum.any?(b, fn a ->
    (Enum.all?(a, fn {x, y} -> x < y end) or Enum.all?(a, fn {x, y} -> x > y end)) and Enum.all?(a, fn {x, y} -> abs(y - x) < 4 end)
  end)
end)
|> Enum.count()
|> IO.puts()
