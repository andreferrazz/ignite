defmodule Flightex.Bookings.Booking do
  @keys [:id, :complete_date, :city_origin, :city_destiny, :user_id]
  @enforce_keys @keys

  defstruct @keys

  def build(complete_date, city_origin, city_destiny, user_id) do
    case UUID.info(user_id) do
      {:ok, _info} -> build_booking(complete_date, city_origin, city_destiny, user_id)
      {:error, _reason} -> {:error, "the given user id is invalid"}
    end
  end

  defp build_booking(complete_date, city_origin, city_destiny, user_id) do
    {
      :ok,
      %__MODULE__{
        id: UUID.uuid4(),
        complete_date: complete_date,
        city_origin: city_origin,
        city_destiny: city_destiny,
        user_id: user_id
      }
    }
  end
end
