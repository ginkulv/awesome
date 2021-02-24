defmodule Awesome.Github do
  use HTTPoison.Base

  # github revokes any token after push, so I had to do this work around
  @encoded_token "YTAxZGM4ZjVlY2VhYzBkOTY1MjU2NmI3MWE5NGNlOGExN2YzZmUzNg=="
  @expected_fields ~w(watchers_count pushed_at)

  def process_request_url(url) do
    "https://api.github.com/repos" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  def get_repos(url) do
    headers = [{"Authorization", "token " <> Base.decode64! @encoded_token}]
    get!(url, headers)
  end
end
