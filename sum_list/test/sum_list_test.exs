defmodule SumListTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns the list sum" do
      list = [1, 2, 3, 4]

      expected_result = 10

      result = SumList.call(list)

      assert result == expected_result
    end
  end
end
