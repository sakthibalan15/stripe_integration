defmodule StripeAppWeb.PaymentController do
  use StripeAppWeb, :controller

  def success(conn, _params) do
    conn
    |> put_flash(:info, "Successfull Payment")
    |> redirect(to: ~p"/stripe/fixed")
  end

  def cancel(conn, _params) do
    conn
    |> put_flash(:error, "Failure Payment")
    |> redirect(to: ~p"/stripe/fixed")
  end
end
