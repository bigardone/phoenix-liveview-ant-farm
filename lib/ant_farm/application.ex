defmodule AntFarm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ant supervisor
      AntFarm.Ant.Supervisor,
      # Start the Ant Supervisor populator
      AntFarm.Ant.Supervisor.Populator,
      # Start the endpoint when the application starts
      AntFarmWeb.Endpoint
      # Starts a worker by calling: AntFarm.Worker.start_link(arg)
      # {AntFarm.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AntFarm.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AntFarmWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
