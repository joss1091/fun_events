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
  def handle_event("generate_message", %{"guest_id" => guest_id}, socket) do
    {:noreply, socket}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Guest")
    |> assign(:guest, Guests.get_guest!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Guest")
    |> assign(:guest, %Guest{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Guests")
    |> assign(:guest, nil)
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
