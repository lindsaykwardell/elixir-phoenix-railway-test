defmodule Railwayphoenix.User do
  use Ecto.Schema

  schema "users" do
    field :username, :string
  end
end