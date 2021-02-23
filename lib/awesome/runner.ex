defmodule Awesome.Runner do

  def update_sections do
    Awesome.Parser.get_sections
    |> Awesome.Repo.insert_sections
    IO.puts "Data is collected"
  end
end
