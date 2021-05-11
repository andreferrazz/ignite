defmodule ListFilterTest do
  use ExUnit.Case

  describe "call/1" do
    test "Filtering an empty list" do
      empty_list = []

      expected = 0

      assert ListFilter.call(empty_list) == expected
    end

    test "Filtering list with not integer elements should returns zero" do
      list_1 = ["12.13", "1.3", "123123.90", "12.324324"]
      list_2 = ["asd", "g", "iuooiweuouro", "pó"]
      list_3 = ["a1b2", "quarenta e 2"]

      expected = 0

      assert ListFilter.call(list_1) == expected
      assert ListFilter.call(list_2) == expected
      assert ListFilter.call(list_3) == expected
    end

    test "filtering list with some odd numbers" do
      list_1 = ["12", "13", "1.2", "1.3"]
      list_2 = ["a1b1.0", "43", "123123", "121212"]
      list_3 = ["1.0", "2.0", "3.0", "4.0", "5.0"]

      expected_1 = 1
      expected_2 = 2
      expected_3 = 3

      assert ListFilter.call(list_1) == expected_1
      assert ListFilter.call(list_2) == expected_2
      assert ListFilter.call(list_3) == expected_3
    end
  end
end
