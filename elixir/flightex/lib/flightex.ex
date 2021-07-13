defmodule Flightex do
  alias Flightex.Bookings.BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: SaveBooking
  alias Flightex.Bookings.Report, as: BookingReport
  alias Flightex.Users.CreateOrUpdate, as: SaveUser
  alias Flightex.Users.UserAgent

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate get_user(user_id), to: UserAgent, as: :get
  defdelegate save_user(params), to: SaveUser, as: :call

  defdelegate get_booking(booking_id), to: BookingAgent, as: :get
  defdelegate save_booking(params), to: SaveBooking, as: :call
  defdelegate generate_booking_report(filename \\ "report.csv"), to: BookingReport, as: :generate
end
