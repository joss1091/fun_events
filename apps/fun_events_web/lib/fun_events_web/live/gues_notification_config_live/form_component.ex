defmodule FunEventsWeb.GuesNotificationConfigLive.FormComponent do
  use FunEventsWeb, :live_component

  alias FunEvents.Notifications

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage gues_notification_config records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="gues_notification_config-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:type]} type="text" label="Type" />
        <.input field={@form[:to]} type="text" label="To" />
        <.input field={@form[:country]} type="text" label="Country" />
        <.input field={@form[:is_default]} type="checkbox" label="Is default" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Gues notification config</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{gues_notification_config: gues_notification_config} = assigns, socket) do
    changeset = Notifications.change_gues_notification_config(gues_notification_config)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"gues_notification_config" => gues_notification_config_params}, socket) do
    changeset =
      socket.assigns.gues_notification_config
      |> Notifications.change_gues_notification_config(gues_notification_config_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"gues_notification_config" => gues_notification_config_params}, socket) do
    save_gues_notification_config(socket, socket.assigns.action, gues_notification_config_params)
  end

  defp save_gues_notification_config(socket, :edit, gues_notification_config_params) do
    case Notifications.update_gues_notification_config(socket.assigns.gues_notification_config, gues_notification_config_params) do
      {:ok, gues_notification_config} ->
        notify_parent({:saved, gues_notification_config})

        {:noreply,
         socket
         |> put_flash(:info, "Gues notification config updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_gues_notification_config(socket, :new, gues_notification_config_params) do
    case Notifications.create_gues_notification_config(gues_notification_config_params) do
      {:ok, gues_notification_config} ->
        notify_parent({:saved, gues_notification_config})

        {:noreply,
         socket
         |> put_flash(:info, "Gues notification config created successfully")
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
