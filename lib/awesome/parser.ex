defmodule Awesome.Section do
  defstruct [:name, :description, :items]
end

defmodule Awesome.Item do
  defstruct [:url, :stars, :days, :full_text]
end

defmodule Awesome.Parser do
  alias Awesome.Github

  def get_sections(file) do
    [content | _resources] = String.split(file, "\n# ")
    [_header | content] = String.split(content, "## ", trim: true)
    content
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn(section) ->
      [name | section] = section
      [description | items] = section
      items = items
              |> Enum.filter(fn(item) -> String.contains? item, "github.com" end)
              |> Enum.map(fn(item) ->
                [_, url] = Regex.run(~r"\((.*?)\)", item)
                case url |> parse_item do
                  [days, stars] -> %Awesome.Item{url: url, stars: stars, days: days, full_text: item}
                  [] -> nil # some links are outdated
                end
              end)
              |> Enum.filter(fn(item) -> item end)
      %Awesome.Section{name: name, description: description, items: items}
    end)
  end

  def parse_item(url) do
    url
    |> URI.parse
    |> Map.get(:path)
    |> Github.get!
    |> Map.get(:body)
    |> Keyword.values
  end
end
