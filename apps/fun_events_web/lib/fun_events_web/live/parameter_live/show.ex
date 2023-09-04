defmodule FunEventsWeb.ParameterLive.Show do
  use FunEventsWeb, :live_view

  alias FunEvents.Parameters

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:parameter, Parameters.get_parameter!(id))}
  end

  defp page_title(:show), do: "Show Parameter"
  defp page_title(:edit), do: "Edit Parameter"
end
