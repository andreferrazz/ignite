defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "Joao",
      cpf: "12345678900",
      email: "joao@fake.co",
      age: 21,
      address: "Rua dos Bobos, nº 0"
    }
  end
end
