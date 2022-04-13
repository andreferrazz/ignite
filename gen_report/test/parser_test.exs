defmodule GenReport.ParserTest do
  use ExUnit.Case

  alias GenReport.Parser

  describe "parse_file/1" do
    test "parse file content to a list of valid data" do
      filename = "data.csv"

      expected = true

      result =
        filename
        |> Parser.parse_file()
        |> Enum.member?(["Joseph", 4, 16, "april", 2020])

      assert result == expected
    end
  end
end
