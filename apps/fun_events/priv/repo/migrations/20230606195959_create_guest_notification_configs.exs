defmodule FunEvents.Repo.Migrations.CreateGuestNotificationConfigs do
  use Ecto.Migration

  def change do
    create table(:guest_notification_configs) do
      add :type, :string
      add :to, :string
      add :country, :string
      add :is_default, :boolean, default: false, null: false
      add :guest_id, references(:guests)

      timestamps()
    end
  end
end
