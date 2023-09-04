defmodule FunEvents.Repo.Migrations.CreateParameters do
  use Ecto.Migration

  def change do
    create table(:parameters) do
      add :name, :string
      add :value, :map
      add :resource_id, :string
      add :resource_type, :string

      timestamps()
    end
  end
end
