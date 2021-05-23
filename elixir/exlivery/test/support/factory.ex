defmodule Exlivery.Factory do
  use ExMachina

  def user_factory do
    %Exlivery.Users.User{
      name: "Joao",
      cpf: "12345678900",
      email: "joao@fake.co",
      age: 21,
      address: "Rua dos Bobos, nº 0"
    }
  end

  def item_factory do
    %Exlivery.Orders.Item{
      category: :pizza,
      description: "Pizza gigante",
      quantity: 1,
      unity_price: Decimal.new("45.9")
    }
  end

  def order_factory do
    %Exlivery.Orders.Order{
      delivery_address: "Rua dos Bobos, nº 0",
      items: build_list(2, :item),
      total_price: Decimal.new("91.8"),
      user_cpf: "12345678900"
    }
  end
end
