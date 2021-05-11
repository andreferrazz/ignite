defmodule ListFilter do
  require Integer

  def call(list) do
    list
    |> Enum.map(&Float.parse/1)
    |> Enum.filter(fn e -> valid?(e) and integer?(e) end)
    |> Enum.map(&get_num_and_round/1)
    |> Enum.filter(&Integer.is_odd/1)
    |> length()
  end

  defp valid?(e), do: e != :error and elem(e, 1) == ""

  defp integer?({num, _str}), do: ceil(num) == floor(num)

  defp get_num_and_round({num, _str}), do: round(num)
end
