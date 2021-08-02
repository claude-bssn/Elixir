defmodule MyAppWeb.PageController do
  use MyAppWeb, :controller
  alias MyApp.Characters

  def index(conn, _param) do
    champ = Characters.fetch_characters["champions"]
    lists = Enum.uniq( Enum.flat_map(champ, fn(row)-> row["tags"]end),fn x -> [x , x] end)
    # lists
    # |> Poison.decode!

    render(conn, "index.html", champions: champ, list: lists)

  end
end
