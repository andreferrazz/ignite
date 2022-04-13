defmodule Exlivery.Orders.Item do
  @categories [:pizza, :hamburguer, :carne, :prato_feito, :japonesa, :sobremesa]
  @keys [:description, :category, :unity_price, :quantity]
  @enforce_keys @keys

  defstruct @keys

  def build(_, category, _, _) when not (category in @categories) do
    {:error, "Given category doesn't exists."}
  end

  def build(_, _, _, quantity) when quantity <= 0 do
    {:error, "Invalid quantity. Must be greater than zero."}
  end

  def build(description, category, unity_price, quantity) do
    unity_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  defp build_item({:ok, unity_price}, description, category, quantity) do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unity_price: unity_price,
       quantity: quantity
     }}
  end

  defp build_item(:error, _, _, _) do
    {:error, "Unity price invalid. Could not convert given value to Decimal."}
  end
end
