defmodule GenReport.Parser do
  @months %{
    1 => "january",
    2 => "february",
    3 => "march",
    4 => "april",
    5 => "may",
    6 => "june",
    7 => "july",
    8 => "august",
    9 => "september",
    10 => "october",
    11 => "november",
    12 => "december"
  }

  def parse_file(filename) do
    "data/#{filename}"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    String.trim(line)
    |> String.split(",")
    |> List.update_at(1, &Integer.parse/1)
    |> List.update_at(2, &Integer.parse/1)
    |> List.update_at(3, &Integer.parse/1)
    |> List.update_at(4, &Integer.parse/1)
    |> format_data()
  end

  defp format_data([name, {hours, ""}, {day, ""}, {month, ""}, {year, ""}]) do
    [name, hours, day, @months[month], year]
  end
end
