defmodule Awesome do
  alias Awesome.{Repo, Section}
  import Ecto.Query

  def get_sections() do
    Repo.all(Section)
    |> Repo.preload(:items)
  end

  def get_sections(min_stars) do
    IO.puts min_stars
    Repo.all(Section)
    |> Repo.preload(items: from(i in Awesome.Item, where: i.stars >= ^min_stars))
    |> Enum.filter(fn(section) -> section.items != [] end)
  end
end
