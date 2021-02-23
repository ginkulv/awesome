defmodule Awesome.Github do
  use HTTPoison.Base

  @github_token "7e84deb26ddd3c051d706a645ce160b8a75e2ff7"
  @expected_fields ~w(watchers_count pushed_at)

  def process_request_url(url) do
    IO.puts "https://api.github.com/repos#{url}?access_token=#{@github_token}"
    "https://api.github.com/repos#{url}?access_token=#{@github_token}"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
