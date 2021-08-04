defmodule MyAppWeb.PageLive do
  use MyAppWeb, :live_view
  alias MyApp.Characters

  def checked?(value) do
    case value do
      "true" -> "checked"
      "false" -> ""
      nil -> ""
    end
  end

  def mount(_params, _session, socket) do
    champs = Characters.fetch_characters()["champions"]
    tags = Enum.uniq_by(Enum.flat_map(champs, fn (row) -> row["tags"] end), fn x -> [x, x] end)
    show_champs = Enum.map(tags, fn(item) -> {item, "true"} end)|> Enum.into(%{})
    list = Map.keys(show_champs)
    checked_champ = Enum.filter(show_champs, fn value -> value == "true" end)|> Enum.into(%{})
    status = "all"

    {:ok, assign(socket, champions: champs, show_champs: checked_champ,  list: list, status: status)}
  end

def handle_event("show_champs", checked_list, socket) do
checked_champ = Enum.filter(checked_list, fn { _key, value} -> value == "true" end)|> Enum.into(%{})
champs = Characters.fetch_characters()["champions"]
filtered_champs = Enum.filter(champs, fn champ -> champ["tags"] == (Map.keys(checked_champ)) end)
status = "filter"

{:noreply, assign(socket, show_champs: checked_champ, filtered_champs: filtered_champs, status: status)}
end

def handle_event("search",  %{"q" => search}, socket) do
  champs = Characters.fetch_characters()["champions"]
  searched_champs = Enum.filter(champs, fn (champ) -> String.contains?(String.downcase(champ["id"]), String.downcase(search)) end)
  status = "search"
  {:noreply, assign(socket, searched_champs: searched_champs, status: status)}
end
end
