defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Order

  describe "build/2" do
    test "when valid parameters are given, return a valid order" do
      user = build(:user)

      items = build_list(2, :item)

      result = Order.build(user, items)

      expected = {:ok, build(:order)}

      assert result == expected
    end

    test "when items is empty, returns an error" do
      user = build(:user)

      items = []

      result = Order.build(user, items)

      expected = {:error, "Invalid parameters"}

      assert result == expected
    end
  end
end
