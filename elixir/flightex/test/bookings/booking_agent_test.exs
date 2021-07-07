defmodule Flightex.Bookings.BookingAgentTest do
  use ExUnit.Case

  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.BookingAgent
  alias Flightex.Users.User
  alias Flightex.Users.UserAgent

  describe "save/1" do
    setup do
      UserAgent.start_link(%{})
      BookingAgent.start_link(%{})
      :ok
    end

    test "save the booking and return the uuid" do
      {:ok, user} = User.build("User", "user@mail.com", "11111111100")
      {:ok, user_id} = UserAgent.save(user)

      {:ok, booking} =
        Booking.build(~N[2021-07-20 18:00:00], "Belo Horizonte", "New York", user_id)

      result = BookingAgent.save(booking)

      assert {:ok, _id} = result
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})
      BookingAgent.start_link(%{})
      :ok
    end

    test "when the booking is found, return the booking" do
      {:ok, user} = User.build("User", "user@mail.com", "11111111100")

      {:ok, user_id} = UserAgent.save(user)

      {:ok, booking} =
        Booking.build(~N[2021-07-20 18:00:00], "Belo Horizonte", "New York", user_id)

      {:ok, booking_id} = BookingAgent.save(booking)

      result = BookingAgent.get(booking_id)

      expected = {
        :ok,
        %Flightex.Bookings.Booking{
          city_destiny: "New York",
          city_origin: "Belo Horizonte",
          complete_date: ~N[2021-07-20 18:00:00],
          id: booking_id,
          user_id: user_id
        }
      }

      assert result == expected
    end

    test "when the booking is not found, return an error" do
      booking_id = UUID.uuid4()

      result = BookingAgent.get(booking_id)

      expected = {:error, "Could not found booking #{booking_id}"}

      assert result == expected
    end
  end
end
