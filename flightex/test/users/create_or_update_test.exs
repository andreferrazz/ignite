defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Users.CreateOrUpdate
  alias Flightex.Users.UserAgent

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when the parameters are valid, return a user" do
      params_1 = %{id: "invalid_uuid", name: "Test", email: "t@t.com", cpf: "00000000011"}
      params_2 = %{id: UUID.uuid4(), name: "Test", email: "t@t.com", cpf: "00000000011"}

      result_1 = CreateOrUpdate.call(params_1)
      result_2 = CreateOrUpdate.call(params_2)

      assert {:ok, _id} = result_1
      assert {:ok, _id} = result_2
    end

    test "when the cpf is invalid, return an error" do
      params_1 = %{id: "invalid_uuid", name: "Test", email: "t@t.com", cpf: 11_111_111_100}
      params_2 = %{id: UUID.uuid4(), name: "Test", email: "t@t.com", cpf: 11_111_111_100}

      result_1 = CreateOrUpdate.call(params_1)
      result_2 = CreateOrUpdate.call(params_2)

      expected_1 = {:error, "Cpf can't be an integer."}
      expected_2 = {:error, "Cpf can't be an integer."}

      assert result_1 == expected_1
      assert result_2 == expected_2
    end
  end
end
