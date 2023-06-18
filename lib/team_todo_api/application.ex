defmodule TeamTodoApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TeamTodoApiWeb.Telemetry,
      # Start the Ecto repository
      TeamTodoApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TeamTodoApi.PubSub},
      # Start Finch
      {Finch, name: TeamTodoApi.Finch},
      # Start the Endpoint (http/https)
      TeamTodoApiWeb.Endpoint
      # Start a worker by calling: TeamTodoApi.Worker.start_link(arg)
      # {TeamTodoApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TeamTodoApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TeamTodoApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
