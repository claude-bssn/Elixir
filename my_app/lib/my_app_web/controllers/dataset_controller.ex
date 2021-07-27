defmodule MyAppWeb.DatasetController do
  use MyAppWeb, :controller

  def show(conn, _params) do
    json(conn, "dataset.json")
  end
end
