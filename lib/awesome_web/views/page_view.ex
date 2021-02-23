defmodule AwesomeWeb.PageView do
  use AwesomeWeb, :view

  def as_html(items) when is_list(items) do
    items
    |> Enum.map(fn(item) -> "#{item.full_text} Days from the last commit: #{item.days}, stars: #{item.stars}" end)
    |> Enum.join("\n")
    |> as_html
  end

  def as_html(text) do
    text
    |> Earmark.as_html!
    |> raw
  end
end
