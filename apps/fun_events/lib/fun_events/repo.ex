defmodule FunEvents.Repo do
  use Ecto.Repo,
    otp_app: :fun_events,
    adapter: Ecto.Adapters.Postgres
end
