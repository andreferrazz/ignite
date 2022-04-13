defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.BookingAgent

  def generate(filename \\ "report.csv", from_date, to_date) do
    lines =
      BookingAgent.get_all()
      |> Map.values()
      |> Enum.filter(&filter_booking_by_date(&1, from_date, to_date))
      |> Enum.map(&parse_booking_to_string/1)

    File.write(filename, lines)
    {:ok, "Report generated successfully"}
  end

  defp filter_booking_by_date(%Booking{complete_date: complete_date}, from_date, to_date) do
    from = NaiveDateTime.compare(complete_date, from_date)
    to = NaiveDateTime.compare(complete_date, to_date)

    case {from, to} do
      {:lt, _} -> false
      {_, :gt} -> false
      _ -> true
    end
  end

  defp parse_booking_to_string(%Booking{
         complete_date: complete_date,
         city_origin: city_origin,
         city_destiny: city_destiny,
         user_id: user_id
       }) do
    "#{user_id},#{city_origin},#{city_destiny},#{complete_date}\n"
  end
end
