defmodule AwesomeWeb.PageController do
  use AwesomeWeb, :controller

  def index(conn, _params) do
    sections = Awesome.Parser.get_sections()
    render(conn, "index.html", sections: sections)
  end
end
