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
      params = %{id: "invalid_uuid", name: "Test", email: "t@t.com", cpf: "00000000011"}

      result = CreateOrUpdate.call(params)

      assert {:ok, _id} = result
    end

    test "when the cpf is invalid, return an error" do
      params = %{id: "invalid_uuid", name: "Test", email: "t@t.com", cpf: 11_111_111_100}

      result = CreateOrUpdate.call(params)

      expected = {:error, "Cpf can't be an integer."}

      assert result == expected
    end
  end
end
