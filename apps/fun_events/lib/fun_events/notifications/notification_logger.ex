defmodule FunEvents.Notifications.NotificationLogger do
  alias FunEvents.Guests.Guest
  use Ecto.Schema
  import Ecto.Changeset

  schema "notification_loggers" do

    field(:date, :utc_datetime)

    field(:type, :string)
    field(:to, :string)
    field(:from, :string)
    belongs_to(:guest, Guest)

    timestamps()
  end

  @doc false
  def changeset(notification_logger, attrs) do
    notification_logger
    |> cast(attrs, [:date, :type, :guest_id, :to, :from])
    |> validate_required([:date, :type, :guest_id, :to, :from])
  end
end
