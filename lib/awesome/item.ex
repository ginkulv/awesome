defmodule Awesome.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :days_from_commit, :integer
    field :full_text, :string
    field :stars, :integer
    field :url, :string
    belongs_to :section, Awesome.Section
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:url, :days_from_commit, :stars, :full_text])
    |> validate_required([:url, :days_from_commit, :stars, :full_text])
  end
end
