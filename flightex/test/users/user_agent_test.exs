defmodule Flightex.Users.UserAgentTest do
  use ExUnit.Case

  alias Flightex.Users.User
  alias Flightex.Users.UserAgent

  describe "save/1" do
    test "when the user is save, returns an tuple with :ok and a message" do
      {:ok, user} = User.build("André", "andre@mail.com", "11111111100")

      UserAgent.start_link(%{})

      result = UserAgent.save(user)

      assert {:ok, _id} = result
    end
  end

  describe "get/1" do
    setup do
      {:ok, user} = User.build("André", "andre@mail.com", "11111111100")

      UserAgent.start_link(%{})

      UserAgent.save(user)

      {:ok, user: user}
    end

    test "when the user is found, returns the user", %{user: user} do
      result = UserAgent.get(user.id)

      expected = {:ok, user}

      assert result == expected
    end

    test "when the user is not found, returns an error" do
      result = UserAgent.get("<id>")

      expected = {:error, "Could not found user <id>"}

      assert result == expected
    end
  end
end
