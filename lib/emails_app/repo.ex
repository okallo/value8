defmodule EmailsApp.Repo do
  use Ecto.Repo,
    otp_app: :emails_app,
    adapter: Ecto.Adapters.Postgres
end
