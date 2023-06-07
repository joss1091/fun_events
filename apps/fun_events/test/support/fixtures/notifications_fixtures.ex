defmodule FunEvents.NotificationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FunEvents.Notifications` context.
  """

  @doc """
  Generate a notification_logger.
  """
  def notification_logger_fixture(attrs \\ %{}) do
    {:ok, notification_logger} =
      attrs
      |> Enum.into(%{

      })
      |> FunEvents.Notifications.create_notification_logger()

    notification_logger
  end

  @doc """
  Generate a gues_notification_config.
  """
  def gues_notification_config_fixture(attrs \\ %{}) do
    {:ok, gues_notification_config} =
      attrs
      |> Enum.into(%{
        country: "some country",
        is_default: true,
        to: "some to",
        type: "some type"
      })
      |> FunEvents.Notifications.create_gues_notification_config()

    gues_notification_config
  end
end
