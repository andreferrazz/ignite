defmodule GenReport do
  alias GenReport.Parser

  def build(filename) when filename == nil or filename == "" do
    {:error, "No filename was provided"}
  end

  def build(filename) do
    result =
      filename
      |> Parser.parse_file()
      |> Enum.reduce(report_acc(), fn row_data, acc -> aggregate_values(acc, row_data) end)

    {:ok, result}
  end

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "The argument provided was not a list"}
  end

  def build_from_many(filenames) when filenames == [] do
    {:error, "No filenames was provided"}
  end

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(report_acc(), fn {:ok, {:ok, report}}, acc -> merge_reports(acc, report) end)

    {:ok, result}
  end

  def merge_reports(report_1, report_2) do
    all_hours = merge_values(report_1["all_hours"], report_2["all_hours"])

    hours_per_month = marge_values_inner(report_1["hours_per_month"], report_2["hours_per_month"])

    hours_per_year = marge_values_inner(report_1["hours_per_year"], report_2["hours_per_year"])

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_values(map1, map2) do
    Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end)
  end

  defp marge_values_inner(map1, map2) do
    Map.merge(map1, map2, fn _k, v1, v2 -> merge_values(v1, v2) end)
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
