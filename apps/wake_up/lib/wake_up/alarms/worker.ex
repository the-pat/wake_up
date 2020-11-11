defmodule WakeUp.Alarms.Worker do
  use GenServer

  require Logger

  @delay :timer.minutes(5)

  def start_link(url) do
    GenServer.start_link(__MODULE__, url)
  end

  def init(url) do
    schedule_work()
    {:ok, url}
  end

  def handle_info(:work, url) do
    Logger.info("START PING '#{url}'")
    response = :hackney.get(url, follow_redirect: true, max_redirect: 5)
    Logger.info("END PING '#{url}'\n\t#{inspect(response)}")

    schedule_work()
    {:noreply, url}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, @delay)
  end
end
