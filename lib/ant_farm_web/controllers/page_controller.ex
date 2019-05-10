defmodule AntFarmWeb.PageController do
  use AntFarmWeb, :controller

  def index(conn, _) do
    render(conn, "index.html")
  end
end
