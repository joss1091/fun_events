defmodule FunEvents.Repo.Migrations.AddFlagToSendNotification do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :send_notification, :boolean, default: true
      add :send_custom_message, :boolean, default: false
    end
  end
end
