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
      {Phoenix.PubSub, name: WakeUp.PubSub},
      # Start a worker by calling: WakeUp.Worker.start_link(arg)
      {WakeUp.Alarms.Manager, []}
    ]

    supervisor = Supervisor.start_link(children, strategy: :one_for_one, name: WakeUp.Supervisor)

    # Start a worker for each URL
    ["https://patrickt-remindme.herokuapp.com/"]
    |> Enum.each(&WakeUp.Alarms.Manager.start_work/1)

    supervisor
  end
end
