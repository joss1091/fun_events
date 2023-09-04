defmodule FunEventsWeb.ParameterLive.FormComponent do
  use FunEventsWeb, :live_component

  alias FunEvents.Parameters

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage parameter records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="parameter-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:value]} type="text" label="Value" />
        <.input field={@form[:resource_id]} type="text" label="Resource" />
        <.input field={@form[:resource_type]} type="text" label="Resource type" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Parameter</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{parameter: parameter} = assigns, socket) do
    changeset = Parameters.change_parameter(parameter)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"parameter" => parameter_params}, socket) do
    changeset =
      socket.assigns.parameter
      |> Parameters.change_parameter(parameter_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"parameter" => parameter_params}, socket) do
    save_parameter(socket, socket.assigns.action, parameter_params)
  end

  defp save_parameter(socket, :edit, parameter_params) do
    case Parameters.update_parameter(socket.assigns.parameter, parameter_params) do
      {:ok, parameter} ->
        notify_parent({:saved, parameter})

        {:noreply,
         socket
         |> put_flash(:info, "Parameter updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_parameter(socket, :new, parameter_params) do
    case Parameters.create_parameter(parameter_params) do
      {:ok, parameter} ->
        notify_parent({:saved, parameter})

        {:noreply,
         socket
         |> put_flash(:info, "Parameter created successfully")
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
