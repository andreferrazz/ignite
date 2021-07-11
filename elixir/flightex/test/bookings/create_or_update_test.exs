defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Flightex.Users.User
  alias Flightex.Users.UserAgent

  describe "call/2" do
    setup do
      UserAgent.start_link(%{})
      BookingAgent.start_link(%{})

      {:ok, user} = User.build("Andre Ferraz", "a@a.c", "11111111100")
      UserAgent.save(user)

      {:ok, booking} = Booking.build(~N[2021-07-11 18:26:22], "Salvador", "New York", user.id)

      BookingAgent.save(booking)

      {:ok, saved_user: user, saved_booking: booking}
    end

    test "update an existing booking", %{saved_booking: saved_booking, saved_user: saved_user} do
      params = %{
        complete_date: ~N[2021-07-01 18:26:22],
        city_origin: "Belo Horizonte",
        city_destiny: "Porto Alegre",
        user_id: saved_user.id
      }

      CreateOrUpdateBooking.call(saved_booking.id, params)

      result = BookingAgent.get(saved_booking.id)

      expected_result = {
        :ok,
        %Booking{
          id: saved_booking.id,
          complete_date: ~N[2021-07-01 18:26:22],
          city_origin: "Belo Horizonte",
          city_destiny: "Porto Alegre",
          user_id: saved_user.id
        }
      }

      assert result == expected_result
    end

    test "create a new booking", %{saved_user: saved_user} do
      params = %{
        complete_date: ~N[2021-07-01 18:26:22],
        city_origin: "Belo Horizonte",
        city_destiny: "Porto Alegre",
        user_id: saved_user.id
      }

      result = CreateOrUpdateBooking.call(nil, params)

      assert {:ok, _id} = result
    end
  end
end
