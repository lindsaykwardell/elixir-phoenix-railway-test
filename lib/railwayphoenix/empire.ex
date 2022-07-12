defmodule Railwayphoenix.Empire do
  use Ecto.Schema

  schema "empires" do
    field :user_id, :integer
    field :name, :string
    field :credits, :integer
  end

  def changeset(empire, params \\ %{}) do
    empire
    |> Ecto.Changeset.cast(params, [:name, :credits])
    |> Ecto.Changeset.validate_required([:name, :credits])
  end
end