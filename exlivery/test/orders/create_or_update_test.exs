defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "11111111100"

      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      item_1 = %{
        description: "Item 1",
        category: :pizza,
        unity_price: 34.7,
        quantity: 2
      }

      item_2 = %{
        description: "Item 2",
        category: :pizza,
        unity_price: 41.0,
        quantity: 1
      }

      {:ok, cpf: cpf, item_1: item_1, item_2: item_2}
    end

    test "create a valid order", %{cpf: cpf, item_1: item_1, item_2: item_2} do
      params = %{user_cpf: cpf, items: [item_1, item_2]}

      result = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = result
    end

    test "when there are no items, returns an error", %{cpf: cpf} do
      params = %{user_cpf: cpf, items: []}

      result = CreateOrUpdate.call(params)

      expected = {:error, "Invalid parameters"}

      assert result == expected
    end

    test "when there are invalid items, returns an error", %{
      cpf: cpf,
      item_1: item_1,
      item_2: item_2
    } do
      params_1 = %{user_cpf: cpf, items: [%{item_1 | quantity: 0}, item_2]}
      params_2 = %{user_cpf: cpf, items: [%{item_1 | category: :invalid_category}, item_2]}
      params_3 = %{user_cpf: cpf, items: [%{item_1 | unity_price: "abc"}, item_2]}

      result_1 = CreateOrUpdate.call(params_1)
      result_2 = CreateOrUpdate.call(params_2)
      result_3 = CreateOrUpdate.call(params_3)

      expected_1 = {:error, "Invalid items"}
      expected_2 = {:error, "Invalid items"}
      expected_3 = {:error, "Invalid items"}

      assert result_1 == expected_1
      assert result_2 == expected_2
      assert result_3 == expected_3
    end

    test "when there is no user for given cpf, returns an error", %{
      item_1: item_1,
      item_2: item_2
    } do
      params = %{user_cpf: "00000000011", items: [item_1, item_2]}

      result = CreateOrUpdate.call(params)

      expected = {:error, "User not found"}

      assert result == expected
    end
  end
end
