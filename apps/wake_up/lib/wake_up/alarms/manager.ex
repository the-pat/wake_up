defmodule WakeUp.Alarms.Manager do
  use DynamicSupervisor

  alias WakeUp.Alarms.Worker

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_work(url) do
    spec = %{id: Worker, start: {Worker, :start_link, [url]}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
