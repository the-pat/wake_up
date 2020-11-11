defmodule WakeUp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      WakeUp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WakeUp.PubSub}
      # Start a worker by calling: WakeUp.Worker.start_link(arg)
      # {WakeUp.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: WakeUp.Supervisor)
  end
end
