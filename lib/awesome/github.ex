defmodule Awesome.Github do
  use HTTPoison.Base

  @github_token "1278a7b27ae0bdfa3c5707fc2982f73c4b098aa1"
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
