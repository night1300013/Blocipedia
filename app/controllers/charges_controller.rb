class ChargesController < ApplicationController
  include ChargesHelper
  before_action :authenticate_user!

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Rails Wikis customer",
      amount: Amount.default
    }
  end

  def create
    customer = StripeTool.create_customer(
      email: params[:stripeEmail],
      stripe_token: params[:stripeToken]
    )

    charge = StripeTool.create_charge(
      customer_id: customer.id,
      amount: Amount.default,
      description: 'Rails Wikis customer'
    )
    redirect_to upgrade_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
