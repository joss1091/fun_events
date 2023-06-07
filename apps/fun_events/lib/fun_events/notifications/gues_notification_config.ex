defmodule FunEvents.Notifications.GuesNotificationConfig do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guest_notification_configs" do
    field :country, :string
    field :is_default, :boolean, default: false
    field :to, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(gues_notification_config, attrs) do
    gues_notification_config
    |> cast(attrs, [:type, :to, :country, :is_default])
    |> validate_required([:type, :to, :country, :is_default])
  end
end
