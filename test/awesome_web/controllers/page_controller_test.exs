defmodule AwesomeWeb.PageControllerTest do
  use AwesomeWeb.ConnCase
  use Awesome.RepoCase

  setup do
    items = [%Item{url: "", full_text: "", stars: 1, days_from_commit: 10},
      %Item{url: "", full_text: "", stars: 10, days_from_commit: 10},
      %Item{url: "", full_text: "", stars: 100, days_from_commit: 10}]
    section = %Section{name: "", description: "", items: items}
    Repo.insert!(section)
    :ok
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert conn.status == 200
    assert conn.assigns.sections |> length == 1
    assert conn.assigns.sections
    |> hd
    |> Map.get(:items)
    |> length == 3
  end

  test "GET / with min_stars=0", %{conn: conn} do
    conn = get(conn, "/", %{min_stars: 0})
    assert conn.status == 200
    assert conn.assigns.sections |> length == 1
    assert conn.assigns.sections
    |> hd
    |> Map.get(:items)
    |> length == 3
  end

  test "GET / with min_stars=10", %{conn: conn} do
    conn = get(conn, "/", %{min_stars: 10})
    assert conn.status == 200
    assert conn.assigns.sections |> length == 1
    assert conn.assigns.sections
    |> hd
    |> Map.get(:items)
    |> length == 2
  end

  test "GET / with min_stars=1000", %{conn: conn} do
    conn = get(conn, "/", %{min_stars: 1000})
    IO.inspect conn.assigns.sections
    assert conn.status == 200
    assert conn.assigns.sections |> length == 0
  end

  test "GET / with min_stars=-1", %{conn: conn} do
    conn = get(conn, "/", %{min_stars: -1})
    assert conn.status == 200
    assert conn.assigns.sections |> length == 1
    assert conn.assigns.sections
    |> hd
    |> Map.get(:items)
    |> length == 3
  end

  test "GET / with min_stars=a", %{conn: conn} do
    conn = get(conn, "/", %{min_stars: "a"})
    assert conn.status == 200
    assert conn.assigns.sections |> length == 1
    assert conn.assigns.sections
    |> hd
    |> Map.get(:items)
    |> length == 3
  end
end
