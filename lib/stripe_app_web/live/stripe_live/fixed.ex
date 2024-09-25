defmodule StripeAppWeb.StripeLive.Fixed do
  use StripeAppWeb, :live_view

  @stripe Application.get_env(:stripe_app, :stripe_cred)

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}))}
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("stripe-checkout", %{"amount" => amount, "email" => email, "name" => name}, socket) do
    IO.inspect amt: amount, name: name, email: email
    {_key, secret_key} = List.keyfind(@stripe, :stripe_secret_key, 0)
    {_s_key, success_url} = List.keyfind(@stripe, :stripe_success_url, 0)
    {_c_key, cancel_url} = List.keyfind(@stripe, :stripe_cancel_url, 0)
    {_p_id, price_id} = List.keyfind(@stripe, :fixed_amount, 0)

    params = %{
      "success_url" => success_url,
      "cancel_url" => cancel_url,
      "customer_email" => email,
      "mode" => "payment",
      "currency" => "inr"
    }


    body = params |> URI.encode_query()
    body = body <> "&line_items[0][price]=#{price_id}&line_items[0][quantity]=1"

    request =
      Finch.build(
        :post,
        "https://api.stripe.com/v1/checkout/sessions",
        [
          {"Authorization", "Bearer #{secret_key}"},
          {"Content-Type", "application/x-www-form-urlencoded"}
        ],
        body
      )
      |> Finch.request(StripeApp.Finch)

      with {:ok, response} <- request do
        IO.inspect res: response
        session = response.body |> Jason.decode!()

        IO.inspect(session)

        {:noreply,
         socket
         |> redirect(external: session["url"])}
      else
        _err ->
          {:noreply,
           socket
           |> put_flash(:error, "Unsuccessful Payment")}
      end

    # {:noreply, socket}
  end
end
