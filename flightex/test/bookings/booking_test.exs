defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "when all parameters are valid, return a booking" do
      complete_date = ~N[2021-07-20 18:00:00]
      city_origin = "Belo Horizonte"
      city_destiny = "New York"
      user_id = UUID.uuid4()

      result = Booking.build(complete_date, city_origin, city_destiny, user_id)

      assert {
               :ok,
               %Flightex.Bookings.Booking{
                 city_destiny: "New York",
                 city_origin: "Belo Horizonte",
                 complete_date: ~N[2021-07-20 18:00:00],
                 id: _id,
                 user_id: _user_id
               }
             } = result
    end

    test "when the user id is not a valid UUID, return an error" do
      complete_date = ~N[2021-07-20 18:00:00]
      city_origin = "Belo Horizonte"
      city_destiny = "New York"
      user_id = "is not an uuid"

      result = Booking.build(complete_date, city_origin, city_destiny, user_id)

      expected = {:error, "the given user id is invalid"}

      assert result == expected
    end
  end
end
