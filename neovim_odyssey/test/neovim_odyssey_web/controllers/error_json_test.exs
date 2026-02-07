defmodule NeovimOdysseyWeb.ErrorJSONTest do
  use NeovimOdysseyWeb.ConnCase, async: true

  test "renders 404" do
    assert NeovimOdysseyWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert NeovimOdysseyWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
