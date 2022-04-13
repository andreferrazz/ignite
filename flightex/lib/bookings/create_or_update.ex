defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.BookingAgent

  def call(%{id: id} = params) do
    case UUID.info(id) do
      {:ok, _info} -> create_or_update_booking(params)
      {:error, _message} -> create_booking(params)
    end
  end

  defp create_or_update_booking(params) do
    case BookingAgent.get(params.id) do
      {:ok, booking} -> update_booking(booking, params)
      {:error, _message} -> create_booking(params)
    end
  end

  defp update_booking(booking, params) do
    booking
    |> Map.merge(%{params | :id => booking.id})
    |> BookingAgent.save()
  end

  defp create_booking(params) do
    params.complete_date
    |> Booking.build(params.city_origin, params.city_destiny, params.user_id)
    |> save_booking()
  end

  defp save_booking({:ok, booking}) do
    BookingAgent.save(booking)
  end

  defp save_booking({:error, _message} = error), do: error
end
