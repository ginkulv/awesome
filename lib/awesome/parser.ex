defmodule Awesome.Section do
  defstruct [:name, :description, :items]
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
      items = parse_items(items)
      %Awesome.Section{name: name, description: description, items: items}
    end)
  end

  defp parse_items(items) do
    items
    |> Enum.filter(fn(item) -> String.contains? item, "github.com" end)
    |> Enum.map(fn(item) ->
      [_, url] = Regex.run(~r"\((.*?)\)", item) # parsing markdown url
      case url |> parse_item do
        [date, stars] ->
          days = get_days_diff(date)
          %Awesome.Item{url: url, days_from_commit: days, stars: stars, full_text: item}
        [] -> nil # some links are outdated
      end
    end)
    |> Enum.filter(fn(item) -> item end)
  end

  defp parse_item(url) do
    url
    |> URI.parse
    |> Map.get(:path)
    |> Github.get!
    |> Map.get(:body)
    |> Keyword.values
  end

  defp get_days_diff(date) do
    date
    |> String.split("T")
    |> hd
    |> Date.from_iso8601!
    |> Date.diff(Date.utc_today)
  end
end
