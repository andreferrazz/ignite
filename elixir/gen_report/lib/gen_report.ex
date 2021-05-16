defmodule GenReport do
  alias GenReport.Parser

  def build() do
    {:error, "No file name was provided"}
  end

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn row_data, acc -> aggregate_values(acc, row_data) end)
  end

  defp aggregate_values(acc, [name, hours, _day, month, year]) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    } = acc

    all_hours = sum_hours(all_hours, name, hours)

    hours_per_month = sum_hours_inner(hours_per_month, name, month, hours)

    hours_per_year = sum_hours_inner(hours_per_year, name, year, hours)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp sum_hours(map, key, value) do
    value = init_value_if_nil(map[key], 0) + value
    Map.put(map, key, value)
  end

  defp sum_hours_inner(map, name, key, value) do
    map[name]
    |> init_value_if_nil(%{})
    |> sum_hours(key, value)
    |> (fn updated -> Map.put(map, name, updated) end).()
  end

  defp init_value_if_nil(value, alternative_value) do
    if value, do: value, else: alternative_value
  end

  defp report_acc, do: build_report(%{}, %{}, %{})

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
