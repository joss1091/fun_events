defmodule FunEventsWeb.ParameterLive.Index do
  use FunEventsWeb, :live_view

  alias FunEvents.Parameters
  alias FunEvents.Parameters.Parameter

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :parameters, Parameters.list_parameters())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Parameter")
    |> assign(:parameter, Parameters.get_parameter!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Parameter")
    |> assign(:parameter, %Parameter{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Parameters")
    |> assign(:parameter, nil)
  end

  @impl true
  def handle_info({FunEventsWeb.ParameterLive.FormComponent, {:saved, parameter}}, socket) do
    {:noreply, stream_insert(socket, :parameters, parameter)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    parameter = Parameters.get_parameter!(id)
    {:ok, _} = Parameters.delete_parameter(parameter)

    {:noreply, stream_delete(socket, :parameters, parameter)}
  end
end
