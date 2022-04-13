defmodule Exlivery.Users.User do
  @keys [:address, :age, :cpf, :email, :name]
  @enforce_keys @keys

  defstruct @keys

  def build(_, age, _, _, _) when age < 18 do
    {:error, "Invalid age. Must be greater than 18."}
  end

  def build(_, _, cpf, _, _) when not is_bitstring(cpf) do
    {:error, "Invalid cpf. Must be a bitstring"}
  end

  def build(address, age, cpf, email, name) do
    {:ok,
     %__MODULE__{
       address: address,
       age: age,
       cpf: cpf,
       email: email,
       name: name
     }}
  end
end
