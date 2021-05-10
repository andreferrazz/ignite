defmodule ListLengthTest do
  use ExUnit.Case

  describe "call/1" do
    test "count an empty list" do
      empty_list = []

      expected = 0

      assert ListLength.call(empty_list) == expected
    end

    test "count list elements" do
      list_1 = [42]
      list_2 = [4, 2]
      list_3 = [1, 2, 3]
      list_4 = [1000, 3, 78, 80, 901, 666]

      expected_1 = 1
      expected_2 = 2
      expected_3 = 3
      expected_4 = 6

      assert ListLength.call(list_1) == expected_1
      assert ListLength.call(list_2) == expected_2
      assert ListLength.call(list_3) == expected_3
      assert ListLength.call(list_4) == expected_4
    end
  end
end
