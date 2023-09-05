defmodule FunEventsWeb.GuestLive.Index do
  use FunEventsWeb, :live_view

  alias FunEvents.Guests
  alias FunEvents.Guests.Guest

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :guests, Guests.list_guests())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("send_message", %{"guest_id" => guest_id}, socket) do
    guest = Guests.get_guest!(guest_id)
    with {:ok, response} <-  FunEvents.WhatsappHandler.build_and_send(guest),
    {:ok, attrs} <- {:ok, %{ last_notification_date: Timex.now()}},
    {:ok, guest} <- Guests.update_guest(guest, attrs) do
      {:noreply, socket |> put_flash(:info, "Se envio correctamente el mensaje") |> assign(:guest, guest)}
    else
      error ->
        IO.inspect(error)
        {:noreply, socket |> put_flash(:info, "No se envio correctamente el mensaje") }
    end

  end

  @impl true
  def handle_event("send_message_bulk", _, socket) do
    guests = Guests.list_guests()
    FunEvents.WhatsappHandler.build_and_send(guests)
    {:noreply, socket |> put_flash(:info, "Se estan enviando los mensajes masivamente")}
  end

  defp apply_action(socket, :edit, %{"id" => id, "event_id" => event_id}) do
    socket
    |> assign(:page_title, "Editar Invitado")
    |> assign(:guest, Guests.get_guest!(id))
    |> assign(:event_id, event_id)
  end



  defp apply_action(socket, :new, %{"event_id" => event_id}) do
    socket
    |> assign(:page_title, "Nuevo invitado")
    |> assign(:guest, %Guest{event_id: event_id})
    |> assign(:event_id, event_id)
  end

  defp apply_action(socket, :index, %{"event_id" => event_id}) do
    socket
    |> assign(:page_title, "Listado de invitados")
    |> assign(:guest, nil)
    |> assign(:event_id, event_id)
  end

  @impl true
  def handle_info({FunEventsWeb.GuestLive.FormComponent, {:saved, guest}}, socket) do
    {:noreply, stream_insert(socket, :guests, guest)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    guest = Guests.get_guest!(id)
    {:ok, _} = Guests.delete_guest(guest)

    {:noreply, stream_delete(socket, :guests, guest)}
  end
end
