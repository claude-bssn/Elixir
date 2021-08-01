defmodule MyAppWeb.DatasetController do
  use MyAppWeb, :controller


  # def index(conn, _params) do
  #   page = File.read!(file())|> Poison.decode!()
  #   render conn, page: page
  # end
  # defp file() do
  #   Path.join(:code.priv_dir(:myapp), "priv/mock_data/dataset.json")
  # end
  @mock_data (
    Application.app_dir(:my_app, "priv/mock_data/dataset.json")
    |> File.read!
    |> Poison.decode!
  )

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(@mock_data)

  end
end
