defmodule Beepboop.Repo do
  use Ecto.Repo,
    otp_app: :beepboop,
    adapter: Ecto.Adapters.Postgres
end
