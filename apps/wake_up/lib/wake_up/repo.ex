defmodule WakeUp.Repo do
  use Ecto.Repo,
    otp_app: :wake_up,
    adapter: Ecto.Adapters.Postgres
end
