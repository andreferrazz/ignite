defmodule GenReportTest do
  use ExUnit.Case

  alias GenReport.Support.ReportFixture

  describe "build/1" do
    test "when a file with valid data is given, returns the report" do
      filename = "data.csv"

      expected = ReportFixture.build()

      result = GenReport.build(filename)

      assert result == expected
    end

    test "when no file name is provided, returns an error" do
      expected = {:error, "No file name was provided"}

      result = GenReport.build()

      assert result == expected
    end
  end
end
