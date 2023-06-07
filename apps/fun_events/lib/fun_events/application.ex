defmodule FunEvents.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      FunEvents.Repo,
      # Start the PubSub system
      Supervisor.child_spec({Phoenix.PubSub, name: FunEvents.PubSub}, id: :admin),
      Supervisor.child_spec({Phoenix.PubSub, name: Landing.PubSub}, id: :landing),
      # Start Finch
      {Finch, name: FunEvents.Finch}
      # Start a worker by calling: FunEvents.Worker.start_link(arg)
      # {FunEvents.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: FunEvents.Supervisor)
  end
end
