defmodule FunEvents.Repo.Migrations.AddFieldGuest do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add(:invite_url, :text)
      add(:invite_url_short, :string)
    end
  end
end
