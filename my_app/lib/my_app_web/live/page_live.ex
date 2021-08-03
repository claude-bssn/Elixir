defmodule MyAppWeb.PageLive do
  use MyAppWeb, :live_view
  alias MyApp.Characters

  def mount(_params, _session, socket) do
    champ = Characters.fetch_characters()["champions"]
    list = Enum.uniq(Enum.flat_map(champ, fn row -> row["tags"] end), fn x -> [x, x] end)
    socket = assign(socket, :champions, champ)
    {:ok, assign(socket, champions: champ, list: list)}
  end


end
