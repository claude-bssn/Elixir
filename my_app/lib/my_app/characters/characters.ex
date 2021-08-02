defmodule MyApp.Characters do
alias MyApp.Characters.Champions
  def fetch_characters() do
    response = Application.app_dir(:my_app, "priv/mock_data/dataset.json")

    response
    |> File.read!
    |> Poison.decode!
    # |> Enum.map(&Champions.new/1)
  end
end
