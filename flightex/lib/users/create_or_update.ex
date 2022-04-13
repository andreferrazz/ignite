defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.User
  alias Flightex.Users.UserAgent

  def call(%{id: id, name: _name, email: _email, cpf: _cpf} = params) do
    id
    |> UUID.info()
    |> get_user_and_save(params)
  end

  defp get_user_and_save({:ok, _info}, params) do
    UserAgent.get(params.id)
    |> save_user(params)
  end

  defp get_user_and_save({:error, _reason} = error, params) do
    save_user(error, params)
  end

  defp save_user({:error, _reason}, %{name: name, email: email, cpf: cpf}) do
    case User.build(name, email, cpf) do
      {:ok, user} -> UserAgent.save(user)
      error -> error
    end
  end

  defp save_user({:ok, %User{} = user}, %{name: name, email: email, cpf: cpf}) do
    %{user | name: name, email: email, cpf: cpf}
    |> UserAgent.save()
  end
end
