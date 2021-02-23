defmodule Awesome.Runner do
  alias Awesome.Parser
  alias Awesome.Repo

  @url "https://raw.githubusercontent.com/h4cc/awesome-elixir/master/README.md"

  def update_sections do
    HTTPoison.start()
    @url
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Parser.get_sections
    |> Repo.insert_sections
    IO.puts "Data is collected"
  end
end
