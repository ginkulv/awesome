defmodule Awesome.Section do
  defstruct [:name, :description, :items]
end

defmodule Awesome.Item do
  defstruct [:url, :stars, :days, :full_text]
end

defmodule Awesome.Parser do

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
      items = Enum.map(items, fn(item) ->
        [_, url] = Regex.run(~r"\((.*)\)", item)
        %Awesome.Item{url: url, full_text: item}
      end)
      %Awesome.Section{name: name, description: description, items: items}
    end)
  end
end
