defmodule FunEventsWeb.NotificationLoggerLive.Index do
  use FunEventsWeb, :live_view

  alias FunEvents.Notifications
  alias FunEvents.Notifications.NotificationLogger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :notification, Notifications.list_notification())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Notification logger")
    |> assign(:notification_logger, Notifications.get_notification_logger!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Notification logger")
    |> assign(:notification_logger, %NotificationLogger{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Notification")
    |> assign(:notification_logger, nil)
  end

  @impl true
  def handle_info({FunEventsWeb.NotificationLoggerLive.FormComponent, {:saved, notification_logger}}, socket) do
    {:noreply, stream_insert(socket, :notification, notification_logger)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    notification_logger = Notifications.get_notification_logger!(id)
    {:ok, _} = Notifications.delete_notification_logger(notification_logger)

    {:noreply, stream_delete(socket, :notification, notification_logger)}
  end
end
