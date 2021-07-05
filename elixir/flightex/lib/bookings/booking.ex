defmodule Flightex.Bookings.Booking do
  @keys [:id, :complete_date, :city_origin, :city_destiny, :id_usuario]
  @enforce_keys @keys

  defstruct @keys

  def build(complete_date, city_origin, city_destiny, id_usuario) do
    {
      :ok,
      %__MODULE__{
        id: UUID.uuid4(),
        complete_date: complete_date,
        city_origin: city_origin,
        city_destiny: city_destiny,
        id_usuario: id_usuario
      }
    }
  end
end
