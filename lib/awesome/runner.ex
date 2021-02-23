defmodule Awesome.Runner do
  use GenServer
  alias Awesome.{Repo, Parser, Section, Item}

  @url "https://raw.githubusercontent.com/h4cc/awesome-elixir/master/README.md"

  def init(arg) do
    {:ok, arg}
  end

  def start_link(arg) do
    update_sections()
    GenServer.start_link(__MODULE__, arg)
  end

  def update_sections do
    IO.puts "Collecting data..."
    Repo.delete_all(Item)
    Repo.delete_all(Section)
    HTTPoison.start()
    @url
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Parser.get_sections
    |> Enum.each(fn(section) ->
      Repo.insert(section)
    end)
    IO.puts "Data is collected"
  end
end
