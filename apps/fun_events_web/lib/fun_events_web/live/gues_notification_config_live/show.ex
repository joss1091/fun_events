defmodule FunEventsWeb.GuesNotificationConfigLive.Show do
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
     |> assign(:gues_notification_config, Notifications.get_gues_notification_config!(id))}
  end

  defp page_title(:show), do: "Show Gues notification config"
  defp page_title(:edit), do: "Edit Gues notification config"
end
