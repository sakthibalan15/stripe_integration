defmodule StripeApp.Repo do
  use Ecto.Repo,
    otp_app: :stripe_app,
    adapter: Ecto.Adapters.Postgres
end
