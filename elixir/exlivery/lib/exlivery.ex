defmodule Exlivery do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate, as: SaveUser

  def start_links do
    UserAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: SaveUser, as: :call
end
