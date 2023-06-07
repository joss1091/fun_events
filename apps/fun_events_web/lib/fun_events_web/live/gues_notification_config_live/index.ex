defmodule FunEventsWeb.GuesNotificationConfigLive.Index do
  use FunEventsWeb, :live_view

  alias FunEvents.Notifications
  alias FunEvents.Notifications.GuesNotificationConfig

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :guest_notification_configs, Notifications.list_guest_notification_configs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gues notification config")
    |> assign(:gues_notification_config, Notifications.get_gues_notification_config!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gues notification config")
    |> assign(:gues_notification_config, %GuesNotificationConfig{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Guest notification configs")
    |> assign(:gues_notification_config, nil)
  end

  @impl true
  def handle_info({FunEventsWeb.GuesNotificationConfigLive.FormComponent, {:saved, gues_notification_config}}, socket) do
    {:noreply, stream_insert(socket, :guest_notification_configs, gues_notification_config)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gues_notification_config = Notifications.get_gues_notification_config!(id)
    {:ok, _} = Notifications.delete_gues_notification_config(gues_notification_config)

    {:noreply, stream_delete(socket, :guest_notification_configs, gues_notification_config)}
  end
end
