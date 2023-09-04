defmodule FunEvents.ParametersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FunEvents.Parameters` context.
  """

  @doc """
  Generate a parameter.
  """
  def parameter_fixture(attrs \\ %{}) do
    {:ok, parameter} =
      attrs
      |> Enum.into(%{
        name: "some name",
        resource_id: "some resource_id",
        resource_type: "some resource_type",
        value: %{}
      })
      |> FunEvents.Parameters.create_parameter()

    parameter
  end
end
