defmodule FunEvents.Parameters.Parameter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parameters" do
    field :name, :string
    field :resource_id, :string
    field :resource_type, :string
    field :value, :map

    timestamps()
  end

  @doc false
  def changeset(parameter, attrs) do
    parameter
    |> cast(attrs, [:name, :value, :resource_id, :resource_type])
    |> validate_required([:name, :value, :resource_id, :resource_type])
  end
end
