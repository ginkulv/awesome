defmodule Awesome.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :url, :string
      add :stars, :integer
      add :days_from_commit, :integer
      add :full_text, :string
      add :section_id, references(:sections)
    end
  end
end
