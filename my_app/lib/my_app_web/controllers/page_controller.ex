defmodule MyAppWeb.PageController do
  use MyAppWeb, :controller
  alias MyApp.Characters

  def index(conn, _param) do

    render(conn, "index.html", champions: Characters.fetch_characters["champions"])

  end
end
