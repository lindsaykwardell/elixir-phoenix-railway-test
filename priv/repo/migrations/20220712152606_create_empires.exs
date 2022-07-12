defmodule Railwayphoenix.Repo.Migrations.CreateEmpires do
  use Ecto.Migration

  def change do
    create table(:empires) do
      add :user_id, references(:users)
      add :name, :string
      add :credits, :integer
    end
  end
end
