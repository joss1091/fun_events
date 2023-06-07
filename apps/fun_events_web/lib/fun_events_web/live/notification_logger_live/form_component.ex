defmodule FunEventsWeb.NotificationLoggerLive.FormComponent do
  use FunEventsWeb, :live_component

  alias FunEvents.Notifications

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage notification_logger records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="notification_logger-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Notification logger</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{notification_logger: notification_logger} = assigns, socket) do
    changeset = Notifications.change_notification_logger(notification_logger)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"notification_logger" => notification_logger_params}, socket) do
    changeset =
      socket.assigns.notification_logger
      |> Notifications.change_notification_logger(notification_logger_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"notification_logger" => notification_logger_params}, socket) do
    save_notification_logger(socket, socket.assigns.action, notification_logger_params)
  end

  defp save_notification_logger(socket, :edit, notification_logger_params) do
    case Notifications.update_notification_logger(socket.assigns.notification_logger, notification_logger_params) do
      {:ok, notification_logger} ->
        notify_parent({:saved, notification_logger})

        {:noreply,
         socket
         |> put_flash(:info, "Notification logger updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_notification_logger(socket, :new, notification_logger_params) do
    case Notifications.create_notification_logger(notification_logger_params) do
      {:ok, notification_logger} ->
        notify_parent({:saved, notification_logger})

        {:noreply,
         socket
         |> put_flash(:info, "Notification logger created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
