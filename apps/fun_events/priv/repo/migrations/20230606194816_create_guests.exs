defmodule FunEvents.Repo.Migrations.CreateGuests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :name, :string
      add :last_name, :string
      add :adult_max, :integer
      add :minor_max, :integer
      add :adult_confirmed, :integer
      add :minor_confirmed, :integer
      add :date_response, :utc_datetime
      add :state, :string
      add :last_notification_date, :utc_datetime
      add :event_id, references(:events)

      timestamps()
    end
  end
end
