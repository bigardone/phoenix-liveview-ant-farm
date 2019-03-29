# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :ant_farm, AntFarmWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zqHnkDiATaagfgvAsGvJbl4Q5CNk/KkE0oiRIqVCy6ZVS6OufW6yDxTHfRWPTJ8x",
  render_errors: [view: AntFarmWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AntFarm.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "Bw48nuNaqZB4hZvvBjtTJerLDgMKGiN/dnMrKMuxi3pFZqeyqiohW+1U9HFJlasx"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Enable LiveView templates
config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# AntFarm configuration
config :ant_farm, colony: [population: 500, width: 1024, height: 600]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
