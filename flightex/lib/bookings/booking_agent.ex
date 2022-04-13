defmodule Flightex.Bookings.BookingAgent do
  use Agent

  alias Flightex.Bookings.Booking
  alias Flightex.Users.UserAgent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{user_id: user_id} = booking) do
    case UserAgent.get(user_id) do
      {:ok, _user_id} -> save_booking(booking)
      error -> error
    end
  end

  def get(id) do
    Agent.get(__MODULE__, fn state -> get_booking(state, id) end)
  end

  def get_all do
    Agent.get(__MODULE__, fn state -> state end)
  end

  defp save_booking(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, fn state -> Map.put(state, id, booking) end)
    {:ok, id}
  end

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Could not found booking #{id}"}
      booking -> {:ok, booking}
    end
  end
end
