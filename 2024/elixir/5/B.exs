"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
# Split into the 2 sections of data
|> String.split("\n\n")
# Parse the rules and cases
|> (fn [rules, cases] ->
  [rules |> String.split("\n") |> Enum.map(&String.split(&1, "|")),
  cases |> String.split("\n") |> Enum.map(&String.split(&1, ","))]
end).()
# Filter the cases that don't match the rules and fix the broken ones
|> (fn [rules, cases] ->
  # Filter the broken cases based on the rules
  Enum.filter(cases, fn case ->
    Enum.any?(rules, fn [fst,snd] ->
      fst_idx = Enum.find_index(case, fn v -> v == fst end)
      snd_idx = Enum.find_index(case, fn v -> v == snd end)
      cond do
        fst_idx == nil or snd_idx == nil -> false
        fst_idx > snd_idx -> true
        true -> false
      end
    end)
  end) |>
  # Fix the broken cases by matching the items being sorted to the rules
  Enum.map(fn case ->
    Enum.sort(case, &( Enum.any?(rules, fn [x,y] -> x == &1 and y == &2 end) ))
  end)
end).()
|> IO.inspect()
# Find the middle and parse it to an integer
|> Enum.map(fn case ->
  String.to_integer(Enum.at(case, floor(length(case)/2)))
end)
|> Enum.sum()
|> IO.puts()
