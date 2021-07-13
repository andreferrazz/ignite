defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  alias Flightex.Bookings.BookingAgent
  alias Flightex.Bookings.Report

  describe "generate/1" do
    test "when the operation succeed, return :ok" do
      BookingAgent.start_link(%{})

      result = Report.generate("report_test.csv")

      expected = :ok

      assert result == expected
    end
  end
end
