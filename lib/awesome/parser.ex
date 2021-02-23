defmodule Awesome.Section do
  defstruct [:name, :description, :items]
end

defmodule Awesome.Item do
  defstruct [:url, :stars, :days, :full_text]
end

defmodule Awesome.Parser do
  alias Awesome.Github

  def get_sections do
    get_file()
    |> parse_file
  end

  defp get_file do
    url = "https://raw.githubusercontent.com/h4cc/awesome-elixir/master/README.md"
    HTTPoison.start()
    %HTTPoison.Response{body: body} = HTTPoison.get! url
    body
  end

  defp parse_file(file) do
    [content | _resources] = String.split(file, "\n# ")
    [_header | content] = String.split(content, "## ", trim: true)
    content
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn(section) ->
      [name | section] = section
      [description | items] = section
      items = items
              |> Enum.filter(fn(item) -> Regex.match?(~r"https:\/\/github.com\/.*", item) end)
              |> Enum.map(fn(item) ->
                [_, url] = Regex.run(~r"\((.*?)\)", item)
                case parse_item(url) do
                  # {:ok, stars, days} -> %Awesome.Item{url: url, stars: stars, days: days, full_text: item}
                  {:error} -> nil
                end
              end)
              |> Enum.filter(fn(item) -> item end)
      %Awesome.Section{name: name, description: description, items: items}
    end)
  end

  def parse_item(url) do
    IO.puts url
    uri = URI.parse url
    {:error}
  end
end
