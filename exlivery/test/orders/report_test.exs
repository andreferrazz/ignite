defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("report_test.csv")

      result = File.read!("report_test.csv")

      expected =
        "12345678900,pizza,1,45.9,pizza,1,45.9,91.8\n" <>
          "12345678900,pizza,1,45.9,pizza,1,45.9,91.8\n"

      assert result == expected
    end
  end
end
