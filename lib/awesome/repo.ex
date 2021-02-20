defmodule Awesome.Repo do
  use GenServer

  def init(arg) do
    :ets.new(:sections, [:set, :public, :named_table])
    Awesome.Runner.update_sections()
    {:ok, arg}
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def get_sections do
    :ets.lookup(:sections, "sections")
    |> hd
    |> elem(1)
  end

  def insert_sections(sections) do
    :ets.insert(:sections, {"sections", sections})
  end

end
