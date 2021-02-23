defmodule AwesomeWeb.PageController do
  use AwesomeWeb, :controller

  def index(conn, _params) do
    sections = Awesome.Repo.get_sections()
    render(conn, "index.html", sections: sections)
  end
end
