defmodule Exlivery.Users.User do
  @keys [:age, :cpf, :email, :name]
  @enforce_keys @keys

  defstruct @keys

  def build(age, _cpf, _email, _name) when age < 18 do
    {:error, "Invalid age. Must be greater than 18."}
  end

  def build(_age, cpf, _email, _name) when not is_bitstring(cpf) do
    {:error, "Invalid cpf. Must be a bitstring"}
  end

  def build(age, cpf, email, name) do
    {:ok,
     %__MODULE__{
       age: age,
       cpf: cpf,
       email: email,
       name: name
     }}
  end
end
