defmodule FunEventsWeb.GuestLive.FormComponent do
  use FunEventsWeb, :live_component

  alias FunEvents.Guests
  alias FunEvents.Guests.Guest

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage guest records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="guest-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Nombre" />
        <.input field={@form[:last_name]} type="text" label="Apellido" />
        <.input field={@form[:adult_max]} type="number" label="Adultos maximo" />
        <.input field={@form[:minor_max]} type="number" label="Menor maximo" />
        <.input field={@form[:phone]} type="text" label="Telefono" />
        <.input field={@form[:send_notification]} type="checkbox" label="Enviar notificacion" />
        <.input field={@form[:send_custom_message]} type="checkbox" label="Enviar mensaje custom" />
        <.input field={@form[:event_id]} value={@event_id} type="hidden"  />
        <:actions>
          <.button phx-disable-with="Guardar...">Guardar</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{guest: guest} = assigns, socket) do
    changeset = Guests.change_guest(guest)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"guest" => guest_params}, socket) do

    changeset =
      socket.assigns.guest
      |> Guests.change_guest(guest_params)
      |> Map.put(:action, :validate)
      |> IO.inspect

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"guest" => guest_params}, socket) do
    save_guest(socket, socket.assigns.action, guest_params )
  end

  defp save_guest(socket, :edit, guest_params) do
    case Guests.update_guest(socket.assigns.guest, guest_params) do
      {:ok, guest} ->
        notify_parent({:saved, guest})

        {:noreply,
         socket
         |> put_flash(:info, "Guest updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_guest(socket, :new, guest_params) do
    case Guests.create_guest(guest_params, &after_create_guest/1) do
      {:ok, guest} ->
        notify_parent({:saved, guest})

        {:noreply,
         socket
         |> put_flash(:info, "Guest created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp after_create_guest(guest) do
    FunEvents.TokenEngine.generate_token(Phoenix.Token, guest)
  end

end
# pk_MC2VfYGts9q1N8tX api key short.io
# sk_zt9XtRcPCkTsxSWW
