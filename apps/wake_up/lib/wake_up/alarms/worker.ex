defmodule WakeUp.Alarms.Worker do
  use GenServer

  @delay :timer.minutes(5)

  def start_link(url) do
    IO.inspect(url)
    GenServer.start_link(__MODULE__, url)
  end

  def init(url) do
    schedule_work()
    {:ok, url}
  end

  def handle_info(:work, url) do
    :hackney.get(url, [], :stream, follow_redirect: true, max_redirect: 5)
    schedule_work()
    {:noreply, url}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, @delay)
  end
end
