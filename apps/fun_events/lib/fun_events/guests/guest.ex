defmodule FunEvents.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guests" do
    field :adult_confirmed, :integer
    field :adult_max, :integer
    field :date_response, :utc_datetime
    field :event_id, :integer
    field :last_name, :string
    field :last_notification_date, :utc_datetime
    field :minor_confirmed, :integer
    field :minor_max, :integer
    field :name, :string
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:name, :last_name, :adult_max, :minor_max, :adult_confirmed, :minor_confirmed, :date_response, :state, :last_notification_date, :event_id])
    |> validate_required([:name, :last_name, :adult_max, :minor_max, :adult_confirmed, :minor_confirmed, :date_response, :state, :last_notification_date, :event_id])
  end
end
