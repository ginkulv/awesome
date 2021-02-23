defmodule Awesome.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      AwesomeWeb.Telemetry,
      {Phoenix.PubSub, name: Awesome.PubSub},
      AwesomeWeb.Endpoint,
      {Awesome.Repo, []},
      Awesome.Runner,
      %{id: "daily", start: {SchedEx, :run_every, [Awesome.Runner, :update_sections, [], "1 1 * * *"]}}
    ]

    opts = [strategy: :one_for_one, name: Awesome.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    AwesomeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
