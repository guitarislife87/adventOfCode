"input.txt"
|> File.read()
|> case do
  {:ok, content} -> content
  {:error, reason} -> "Error reading file: #{reason}"
end
|> String.split(~r/^[\d\s]*$/m, trim: true)
|> IO.inspect()
