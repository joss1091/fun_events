defmodule FunEvents.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FunEvents.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-06-05],
        name: "some name",
        status: "some status",
        time_zone: "some time_zone"
      })
      |> FunEvents.Events.create_event()

    event
  end
end
