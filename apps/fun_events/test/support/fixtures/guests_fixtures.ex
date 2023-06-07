defmodule FunEvents.GuestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FunEvents.Guests` context.
  """

  @doc """
  Generate a guest.
  """
  def guest_fixture(attrs \\ %{}) do
    {:ok, guest} =
      attrs
      |> Enum.into(%{
        adult_confirmed: 42,
        adult_max: 42,
        date_response: ~U[2023-06-05 19:48:00Z],
        event_id: 42,
        last_name: "some last_name",
        last_notification_date: ~U[2023-06-05 19:48:00Z],
        minor_confirmed: 42,
        minor_max: 42,
        name: "some name",
        state: "some state"
      })
      |> FunEvents.Guests.create_guest()

    guest
  end
end
