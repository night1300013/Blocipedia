require 'stripe'

class CreditCardService
  def initialize(params)
    @card = params[:card]
    @amount = params[:amount]
    @email = params[:email]
    @customer = params[:customer]
    @currency = params[:currency]
  end

  def charge
    begin
      #This will return a Stripe::Charge object
      external_charge_service.create(charge_attributes)
    rescue Stripe::CardError => e
       puts "*******#{e.message}"
#       redirect_to new_charge_path
    end
  end

  def create_customer
    begin
      #This will return a Stripe::Customer object
      external_customer_service.create(customer_attributes)
    rescue
      false
    end
  end

  private

  attr_reader :card, :amount, :email, :customer, :currency

  def external_charge_service
    Stripe::Charge
  end

  def external_customer_service
    Stripe::Customer
  end

  def charge_attributes
    {
      customer: customer,
      amount: amount,
      currency: currency
    }
  end

  def customer_attributes
    {
      email: email,
      card: card
    }
  end
end
