defmodule AwesomeWeb.PageController do
  use AwesomeWeb, :controller

  def index(conn, %{"min_stars" => min_stars}) do
    sections = case Integer.parse(min_stars) do
      {min_stars, ""} -> Awesome.get_sections(min_stars)
      _ -> Awesome.get_sections()
    end
    render(conn, "index.html", sections: sections)
  end

  def index(conn, _params) do
    sections = Awesome.get_sections()
    render(conn, "index.html", sections: sections)
  end

end
