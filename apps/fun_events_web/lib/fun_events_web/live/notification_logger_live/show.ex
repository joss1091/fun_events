defmodule FunEventsWeb.NotificationLoggerLive.Show do
  use FunEventsWeb, :live_view

  alias FunEvents.Notifications

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:notification_logger, Notifications.get_notification_logger!(id))}
  end

  defp page_title(:show), do: "Show Notification logger"
  defp page_title(:edit), do: "Edit Notification logger"
end
