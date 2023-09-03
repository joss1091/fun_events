defmodule FunEvents.Repo.Migrations.AddMessageTextToGuest do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :message, :text
    end
  end
end
