defmodule Awesome.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Awesome.{Repo, Item, Section}

      import Ecto
      import Ecto.Query
      import Awesome.RepoCase

    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Awesome.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Awesome.Repo, {:shared, self()})
    end

    :ok
  end
end
