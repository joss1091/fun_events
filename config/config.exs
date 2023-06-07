# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :landing,
  ecto_repos: [FunEvents.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :landing, Landing.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: Landing.ErrorHTML, json: Landing.ErrorJSON],
    layout: false
  ],
  pubsub_server: Landing.PubSub,
  live_view: [signing_salt: "7Se4gAqf"]


# Configure Mix tasks and generators
config :fun_events,
  ecto_repos: [FunEvents.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :fun_events, FunEvents.Mailer, adapter: Swoosh.Adapters.Local

config :fun_events_web,
  ecto_repos: [FunEvents.Repo],
  generators: [context_app: :fun_events]

# Configures the endpoint
config :fun_events_web, FunEventsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: FunEventsWeb.ErrorHTML, json: FunEventsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: FunEvents.PubSub,
  live_view: [signing_salt: "IDVF4a6G"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/fun_events_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ],
  landing: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/landing/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/fun_events_web/assets", __DIR__)
  ],
  landing: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/landing/assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
