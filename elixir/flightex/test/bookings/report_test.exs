defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  alias Flightex.Bookings.BookingAgent
  alias Flightex.Bookings.Report

  describe "generate/3" do
    test "when the operation succeed, return :ok" do
      BookingAgent.start_link(%{})

      from_date = ~N[2021-08-03 00:00:00]
      to_date = ~N[2021-08-30 23:59:00]

      result = Report.generate("report_test.csv", from_date, to_date)

      expected = {:ok, "Report generated successfully"}

      assert result == expected
    end
  end
end
