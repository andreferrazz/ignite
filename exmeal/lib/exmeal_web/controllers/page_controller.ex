defmodule ExmealWeb.PageController do
  use ExmealWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
