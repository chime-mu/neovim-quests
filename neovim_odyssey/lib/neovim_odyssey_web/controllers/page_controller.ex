defmodule NeovimOdysseyWeb.PageController do
  use NeovimOdysseyWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
