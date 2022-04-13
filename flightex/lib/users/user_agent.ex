defmodule Flightex.Users.UserAgent do
  use Agent

  alias Flightex.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{id: id} = user) do
    Agent.update(__MODULE__, fn state -> Map.put(state, id, user) end)

    case get(id) do
      {:error, _reason} -> {:error, "could not save the user"}
      {:ok, user} -> {:ok, user.id}
    end
  end

  def get(id) do
    Agent.get(__MODULE__, fn state -> get_user(state, id) end)
  end

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Could not found user #{id}"}
      user -> {:ok, user}
    end
  end
end
