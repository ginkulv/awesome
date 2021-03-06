use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :awesome, AwesomeWeb.Endpoint,
  http: [port: 4002],
  server: false

config :awesome, Awesome.Repo,
  username: "postgres",
  password: "",
  database: "awesome_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Print only warnings and errors during test
config :logger, level: :warn
