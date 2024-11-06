defmodule StripeApp.CheckoutsTest do
  use StripeApp.DataCase

  alias StripeApp.Checkouts

  describe "checkouts" do
    alias StripeApp.Checkouts.Checkout

    import StripeApp.CheckoutsFixtures

    @invalid_attrs %{name: nil, status: nil, currency: nil, email: nil, amount: nil, payment_intent_id: nil, payment_method_id: nil}

    test "list_checkouts/0 returns all checkouts" do
      checkout = checkout_fixture()
      assert Checkouts.list_checkouts() == [checkout]
    end

    test "get_checkout!/1 returns the checkout with given id" do
      checkout = checkout_fixture()
      assert Checkouts.get_checkout!(checkout.id) == checkout
    end

    test "create_checkout/1 with valid data creates a checkout" do
      valid_attrs = %{name: "some name", status: "some status", currency: "some currency", email: "some email", amount: 42, payment_intent_id: "some payment_intent_id", payment_method_id: "some payment_method_id"}

      assert {:ok, %Checkout{} = checkout} = Checkouts.create_checkout(valid_attrs)
      assert checkout.name == "some name"
      assert checkout.status == "some status"
      assert checkout.currency == "some currency"
      assert checkout.email == "some email"
      assert checkout.amount == 42
      assert checkout.payment_intent_id == "some payment_intent_id"
      assert checkout.payment_method_id == "some payment_method_id"
    end

    test "create_checkout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Checkouts.create_checkout(@invalid_attrs)
    end

    test "update_checkout/2 with valid data updates the checkout" do
      checkout = checkout_fixture()
      update_attrs = %{name: "some updated name", status: "some updated status", currency: "some updated currency", email: "some updated email", amount: 43, payment_intent_id: "some updated payment_intent_id", payment_method_id: "some updated payment_method_id"}

      assert {:ok, %Checkout{} = checkout} = Checkouts.update_checkout(checkout, update_attrs)
      assert checkout.name == "some updated name"
      assert checkout.status == "some updated status"
      assert checkout.currency == "some updated currency"
      assert checkout.email == "some updated email"
      assert checkout.amount == 43
      assert checkout.payment_intent_id == "some updated payment_intent_id"
      assert checkout.payment_method_id == "some updated payment_method_id"
    end

    test "update_checkout/2 with invalid data returns error changeset" do
      checkout = checkout_fixture()
      assert {:error, %Ecto.Changeset{}} = Checkouts.update_checkout(checkout, @invalid_attrs)
      assert checkout == Checkouts.get_checkout!(checkout.id)
    end

    test "delete_checkout/1 deletes the checkout" do
      checkout = checkout_fixture()
      assert {:ok, %Checkout{}} = Checkouts.delete_checkout(checkout)
      assert_raise Ecto.NoResultsError, fn -> Checkouts.get_checkout!(checkout.id) end
    end

    test "change_checkout/1 returns a checkout changeset" do
      checkout = checkout_fixture()
      assert %Ecto.Changeset{} = Checkouts.change_checkout(checkout)
    end
  end
end
