defmodule Awesome.GithubTest do
  use ExUnit.Case
  alias Awesome.Github

  @url "https://github.com/ginkulv/awesome"

  test "get repo" do
    assert @url
    |> URI.parse
    |> Map.get(:path)
    |> Github.get_repos
    |> Map.get(:status_code) == 200
  end

end
