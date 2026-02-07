defmodule NeovimOdysseyWeb.PageControllerTest do
  use NeovimOdysseyWeb.ConnCase

  test "GET / renders dashboard", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Neovim Odyssey"
  end
end
