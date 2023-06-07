import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :landing, Landing.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "G49ULP+DpgR4WS4wtIosqV7odZzjEA+K8Os/hQGLTpyggyLeIbmIAMp3ugfsdkJd",
  server: false

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fun_events, FunEvents.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "fun_events_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fun_events_web, FunEventsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "YId3j8yVc8bC1czs3r3g2UiMc68kgcP6bxFhff+QmkXeXIHq82qzBcFadEVNI1p7",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails.
config :fun_events, FunEvents.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
