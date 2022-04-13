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

    test "when filename is nil or empty, returns an error" do
      filename_1 = nil
      filename_2 = ""

      expected = {:error, "No filename was provided"}

      result_1 = GenReport.build(filename_1)
      result_2 = GenReport.build(filename_2)

      assert result_1 == expected
      assert result_2 == expected
    end
  end

  describe "build_from_many/1" do
    test "when files with valid data is given, returns the report" do
      filenames = ["part_1.csv", "part_2.csv", "part_3.csv"]

      expected = ReportFixture.build()

      result = GenReport.build_from_many(filenames)

      assert result == expected
    end

    test "when no list is provided or the list is empty, returns an error" do
      filenames_1 = nil
      filenames_2 = []

      expected_1 = {:error, "The argument provided was not a list"}
      expected_2 = {:error, "No filenames was provided"}

      result_1 = GenReport.build_from_many(filenames_1)
      result_2 = GenReport.build_from_many(filenames_2)

      assert result_1 == expected_1
      assert result_2 == expected_2
    end
  end
end
