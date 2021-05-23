defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Item

  describe "build/4" do
    test "when valid parameters are given, returns a valid item" do
      result = Item.build("Pizza gigante", :pizza, 45.90, 1)

      expected = {:ok, build(:item)}

      assert result == expected
    end

    test "when category doesn't exists, returns an error" do
      result = Item.build("Pizza gigante", :invalid_category, 45.90, 1)

      expected = {:error, "Given category doesn't exists."}

      assert result == expected
    end

    test "when price is invalid, returns an error" do
      result = Item.build("Pizza gigante", :pizza, "invalid_value", 1)

      expected = {:error, "Unity price invalid. Could not convert given value to Decimal."}

      assert result == expected
    end

    test "when quantity isn't greater than zero, returns an error" do
      result_1 = Item.build("Pizza gigante", :pizza, 45.90, 0)
      result_2 = Item.build("Pizza gigante", :pizza, 45.90, -2)

      expected = {:error, "Invalid quantity. Must be greater than zero."}

      assert result_1 == expected
      assert result_2 == expected
    end
  end
end
