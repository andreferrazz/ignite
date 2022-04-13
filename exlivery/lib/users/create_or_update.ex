defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{address: address, name: name, cpf: cpf, age: age, email: email}) do
    address
    |> User.build(age, cpf, email, name)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)
    {:ok, "User created successfully"}
  end

  defp save_user({:error, _} = error), do: error
end
