defmodule MorkBorgWeb.PageController do
  use MorkBorgWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
