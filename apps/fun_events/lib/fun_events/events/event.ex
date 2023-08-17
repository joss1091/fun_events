defmodule FunEvents.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date, :utc_datetime
    field :name, :string
    field :status, :string
    field :time_zone, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:date, :name, :status, :time_zone])
    |> validate_required([:date, :name, :status, :time_zone])
  end
end
