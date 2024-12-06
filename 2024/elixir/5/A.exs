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
# Filter the cases based on the rules
|> (fn [rules, cases] ->
  Enum.filter(cases, fn case ->
    Enum.all?(rules, fn [fst,snd] ->
      fst_idx = Enum.find_index(case, fn v -> v == fst end)
      snd_idx = Enum.find_index(case, fn v -> v == snd end)
      cond do
        fst_idx == nil or snd_idx == nil -> true
        fst_idx < snd_idx -> true
        true -> false
      end
    end)
  end)
end).()
|> IO.inspect()
# Find the middle and parse it to an integer
|> Enum.map(fn case ->
  String.to_integer(Enum.at(case, floor(length(case)/2)))
end)
|> Enum.sum()
|> IO.puts()
