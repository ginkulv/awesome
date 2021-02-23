defmodule Awesome.Section do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sections" do
    field :description, :string
    field :name, :string
    has_many :items, Awesome.Item, on_delete: :delete_all
  end

  @doc false
  def changeset(section, attrs) do
    section
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
