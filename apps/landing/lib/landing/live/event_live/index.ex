defmodule Landing.EventLive.Index do
  use Landing, :live_view
  alias FunEvents.Guests
  alias FunEvents.Events
  alias FunEvents.Guests.Guest
  alias Phoenix.LiveView.JS
  @impl true
  def mount(params, _session, socket) do

    {:ok, socket |> load_context(params)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("validate", _, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("save", %{"guest" => guest_params}, socket) do
    guest_params =
      guest_params
      |> Map.put("date_response", Timex.now())
      |> Map.put("state", "confirmed")
    Guests.confirm_guest(socket.assigns.guest, guest_params)
    {:noreply, socket |> put_flash(:info, "Se confirmo correctamente tu asistencia")}
  end

  @impl true
  def handle_event("reject", _, socket) do
    guest_params =
      %{}
      |> Map.put("date_response", Timex.now())
      |> Map.put("state", "confirmed")
      |> Map.put("adult_confirmed", 0)
    Guests.confirm_guest(socket.assigns.guest, guest_params)
    {:noreply, socket |> put_flash(:info, "Se actualizo correctamente, que no podras asistir")}
  end


  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Boda de J&K")
    |> assign(:event, nil)
  end

  defp load_context(socket, %{"token" => token, "slug" => slug}) do
    with {:ok, payload} <-  Phoenix.Token.verify(Landing.Endpoint, "ju7nHQeQCEIGe7W7vhHLm2YkhyiNil2Fo3fW4TaslkwBTytzzzNmphz9uocma/n0", token) |> IO.inspect do
      guest = Guests.get_guest!(payload.id) |> IO.inspect
      event = Events.get_event!(slug)
      chnageset = Guests.change_guest(guest || %Guest{})
      socket
      |> assign(:guest, guest)
      |> assign(:event, event)
      |> assign(:form, to_form(chnageset))
    else
    _ ->
      event = Events.get_event!(slug)
      chnageset = Guests.change_guest( %Guest{})
      socket
      |> assign(:guest, nil)
      |> assign(:event, event)
      |> assign(:form, to_form(chnageset))
    end


  end

  defp load_context(socket, %{ "slug" => slug}) do
    event = Events.get_event!(slug)
    chnageset = Guests.change_guest(%Guest{})
    socket
    |> assign(:guest, nil)
    |> assign(:event, event)
    |> assign(:form, to_form(chnageset))

  end




end
