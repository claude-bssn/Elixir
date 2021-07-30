defmodule MyAppWeb.DatasetController do
  use MyAppWeb, :controller

  def index(conn, _params) do
    json(conn, "dataset.json")
  end
end
