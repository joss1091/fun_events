defmodule FunEvents.Repo.Migrations.AddPhoneToGuest do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :phone, :string
      add :country, :string, default: "MX"
      add :token, :string
    end
  end
end
