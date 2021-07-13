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

  describe "get_all/0" do
    test "when called, should return a map: id -> booking" do
      Flightex.start_agents()

      {:ok, user_id} = Flightex.save_user(%{id: nil, name: "Joao", email: "j@w", cpf: "12345678"})

      {:ok, booking_id_1} =
        Flightex.save_booking(%{
          id: nil,
          complete_date: ~N[2021-07-20 18:00:00],
          city_origin: "Belo Horizonte",
          city_destiny: "New York",
          user_id: user_id
        })

      {:ok, booking_id_2} =
        Flightex.save_booking(%{
          id: nil,
          complete_date: ~N[2021-08-01 15:00:00],
          city_origin: "Rome",
          city_destiny: "London",
          user_id: user_id
        })

      result = BookingAgent.get_all()

      expected = %{
        booking_id_1 => %Flightex.Bookings.Booking{
          city_destiny: "New York",
          city_origin: "Belo Horizonte",
          complete_date: ~N[2021-07-20 18:00:00],
          id: booking_id_1,
          user_id: user_id
        },
        booking_id_2 => %Flightex.Bookings.Booking{
          city_destiny: "London",
          city_origin: "Rome",
          complete_date: ~N[2021-08-01 15:00:00],
          id: booking_id_2,
          user_id: user_id
        }
      }

      assert result == expected
    end
  end
end
