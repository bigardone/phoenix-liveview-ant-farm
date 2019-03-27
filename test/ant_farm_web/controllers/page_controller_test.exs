defmodule AntFarmWeb.PageControllerTest do
  use AntFarmWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Phoenix LiveView AntFarm"
  end
end
