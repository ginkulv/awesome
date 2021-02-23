defmodule Awesome.Github do
  use HTTPoison.Base

  @github_token "e5dde8be55d67d01f328540be88e4f2e1d37e6c1"
  @expected_fields ~w(watchers_count pushed_at)

  def process_request_url(url) do
    "https://api.github.com/repos#{url}?access_token=#{@github_token}"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
