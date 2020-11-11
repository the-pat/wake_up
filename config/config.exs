# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :wake_up,
  ecto_repos: [WakeUp.Repo]

config :wake_up_web,
  ecto_repos: [WakeUp.Repo],
  generators: [context_app: :wake_up, binary_id: true]

# Configures the endpoint
config :wake_up_web, WakeUpWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pdah6YgQNuDFlbVoIDI13EwEj6wDWKvyuZCtRkgpaG3XXO/9GD0BFbP2GkFOo5rq",
  render_errors: [view: WakeUpWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WakeUp.PubSub,
  live_view: [signing_salt: "bgCpwnL8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
