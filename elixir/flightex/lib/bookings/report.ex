defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.BookingAgent

  def generate(filename \\ "report.csv") do
    lines =
      BookingAgent.get_all()
      |> Map.values()
      |> Enum.map(&parse_booking_to_string/1)

    File.write(filename, lines)
  end

  defp parse_booking_to_string(%Booking{
         id: id,
         complete_date: complete_date,
         city_origin: city_origin,
         city_destiny: city_destiny,
         user_id: user_id
       }) do
    "#{id},#{complete_date},#{city_origin},#{city_destiny},#{user_id}\n"
  end
end
