import Config

config :stripe_app, :stripe_cred,
  stripe_key:
    "xxxx",
  stripe_secret_key:
    "xxxxx",
  stripe_success_url: "http://localhost:4000/payment/success",
  stripe_cancel_url: "http://localhost:4000/payment/cancel",
  fixed_amount: "xxxx"
