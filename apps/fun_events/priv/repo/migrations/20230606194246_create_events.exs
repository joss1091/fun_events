defmodule FunEvents.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :date, :utc_datetime
      add :name, :string
      add :status, :string
      add :time_zone, :string

      timestamps()
    end
  end
end
