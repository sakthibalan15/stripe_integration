defmodule StripeApp.Checkouts.Checkout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "checkouts" do
    field :name, :string
    field :status, :string
    field :currency, :string
    field :email, :string
    field :amount, :integer
    field :payment_intent_id, :string
    field :payment_method_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(checkout, attrs) do
    checkout
    |> cast(attrs, [:email, :name, :amount, :currency, :payment_intent_id, :payment_method_id, :status])
    |> validate_required([:email, :name, :amount, :currency])
  end
end
