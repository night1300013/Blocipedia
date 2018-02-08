class ChargesController < ApplicationController
  include ChargesHelper
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    redirect_to upgrade_path(current_user)
  end
end

private
