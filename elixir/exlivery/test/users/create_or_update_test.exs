defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when the given parameters are valid, returns a success message" do
      params = %{
        address: "Rua A, nº 100",
        name: "Joao",
        cpf: "11111111100",
        age: 32,
        email: "joao@mail.com"
      }

      result = CreateOrUpdate.call(params)

      expected = {:ok, "User created successfully"}

      assert result == expected
    end

    test "when there are invalid parameters, returns an error" do
      params_1 = %{
        address: "Rua A, nº 100",
        name: "Joao",
        cpf: "11111111100",
        age: 17,
        email: "joao@mail.com"
      }

      params_2 = %{
        address: "Rua A, nº 100",
        name: "Joao",
        cpf: 11_111_111_100,
        age: 32,
        email: "joao@mail.com"
      }

      result_1 = CreateOrUpdate.call(params_1)
      result_2 = CreateOrUpdate.call(params_2)

      expected_1 = {:error, "Invalid age. Must be greater than 18."}
      expected_2 = {:error, "Invalid cpf. Must be a bitstring"}

      assert result_1 == expected_1
      assert result_2 == expected_2
    end
  end
end
