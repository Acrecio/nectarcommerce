# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :user_store_app, UserStoreApp.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "OCmYBc/UWx2X7siztTF+0bg4vjvHo/zBRWLwtdDebwhHLmQiFfjKNzX6lMHom440",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: UserStoreApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

import_config "../apps/*/config/config.exs"

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Nectar.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Nectar.GuardianSerializer,
  secret_key: to_string(Mix.env)
