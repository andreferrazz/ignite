defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "save/1" do
    test "saves the order" do
      OrderAgent.start_link(%{})

      order = build(:order)

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})
      :ok
    end

    test "when order is found, returns the order" do
      order = build(:order)

      {:ok, uuid} = OrderAgent.save(order)

      result = OrderAgent.get(uuid)

      expected = {:ok, order}

      assert result == expected
    end

    test "when order is not found, returns an error" do
      result = OrderAgent.get("00000000011")

      expected = {:error, "Order not found"}

      assert result == expected
    end
  end
end
