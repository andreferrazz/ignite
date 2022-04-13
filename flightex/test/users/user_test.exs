defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  describe "build/3" do
    test "when all params are valid, returns the user" do
      result = User.build("André", "andre@mail.com", "00000000011")

      assert {:ok,
              %User{
                cpf: "00000000011",
                email: "andre@mail.com",
                id: _id,
                name: "André"
              }} = result
    end

    test "when cpf is integer, returns an error" do
      result = User.build("André", "andre@mail.com", 00_000_000_011)

      expected = {:error, "Cpf can't be an integer."}

      assert result == expected
    end
  end
end
