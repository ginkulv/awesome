defmodule Awesome.Repo.Migrations.AlterItems do
  use Ecto.Migration

  def change do
    alter table(:items) do
      modify :full_text, :text
    end
  end
end
