defmodule MyAppWeb.DatasetController do
  use MyAppWeb, :controller
  alias MyApp.Characters

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(Characters.fetch_characters())

  end
end
