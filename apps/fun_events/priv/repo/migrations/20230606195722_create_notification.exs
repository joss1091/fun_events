defmodule FunEvents.Repo.Migrations.CreateNotification do
  use Ecto.Migration

  def change do
    create table(:notification_loggers) do
      add :to, :string
      add :from, :string
      add :date, :utc_datetime
      add :guest_id, references(:guests)
      timestamps()
    end
  end
end
