# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :awesome, ecto_repos: [Awesome.Repo]

config :awesome, Awesome.Repo,
  database: "awesome",
  username: "postgres",
  password: "",
  hostname: "localhost",
  port: "5432"

# Configures the endpoint
config :awesome, AwesomeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "M90g4CqS9U/ifAr5c9Err5De+I/JVjLFWc+6V2RdBbKkyQ1Bqdht2OFQDrD6/ZrF",
  render_errors: [view: AwesomeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Awesome.PubSub,
  live_view: [signing_salt: "+SKKxc2r"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
