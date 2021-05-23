defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  describe "build/5" do
    test "when valid parameters are given, return a valid user" do
      result = User.build("Rua dos bobos, nº 0", 19, "12345678900", "bobo@fake.co", "bobo")

      expected =
        {:ok,
         %Exlivery.Users.User{
           address: "Rua dos bobos, nº 0",
           age: 19,
           cpf: "12345678900",
           email: "bobo@fake.co",
           name: "bobo"
         }}

      assert result == expected
    end

    test "when age is less than 18, return an error" do
      result = User.build("Rua dos bobos, nº 0", 17, "12345678900", "bobo@fake.co", "bobo")

      expected = {:error, "Invalid age. Must be greater than 18."}

      assert result == expected
    end

    test "when cpf is not a bitstring, return an error" do
      result = User.build("Rua dos bobos, nº 0", 19, 12_345_678_900, "bobo@fake.co", "bobo")

      expected = {:error, "Invalid cpf. Must be a bitstring"}

      assert result == expected
    end
  end
end
