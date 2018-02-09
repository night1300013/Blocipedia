require 'stripe'

class StripeTool
  def self.create_customer(email: params[:email], stripe_token: params[:stripe_token])
    Stripe::Customer.create(
      email: email,
      source: stripe_token
    )
  end

  def self.create_charge(customer_id: params[:customer_id], amount: params[:amount], description: params[:description])
    Stripe::Charge.create(
      customer: customer_id,
      amount: amount,
      description: description,
      currency: 'usd'
    )
  end
end
