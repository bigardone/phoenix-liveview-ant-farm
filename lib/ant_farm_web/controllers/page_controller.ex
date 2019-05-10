defmodule AntFarmWeb.PageController do
  use AntFarmWeb, :controller

  alias AntFarm.Ant.Supervisor, as: Colony

  def index(conn, _) do
    conn
    |> assign(:ants, Colony.ants())
    |> render("index.html")
  end
end
