# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include ChargesHelper
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    registration = register_with_credit_card_service
    if registration
      # Save the id from the Stripe::Customer object
      add_customer_id_to_user(registration["id"])
    else
      false
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def downgrade
    @user = current_user
    @user.update_attribute(:role, 'standard')
    if @user.save
      flash[:notice] = "Downgrade successfully."
      change_wiki_to_public(@user)
    else
      flash.now[:alert] = "Downgrade failed. Please try again later."
    end
    redirect_to edit_user_registration_path(@user)
  end

  def upgrade
    @user = current_user
    @user.update_attribute(:role, 'premium')
    charge_with_credit_card_service(@user)

    if @user.save
      flash[:notice] = "Upgrade successfully."
    else
      flash.now[:alert] = "Upgrade failed. Please try again later."
    end
    redirect_to edit_user_registration_path(@user)
  end

  private

  def change_wiki_to_public(user)
    user.wikis.each do |wiki|
      wiki.private = false
      wiki.save!
    end
  end

  def register_with_credit_card_service
    CreditCardService.new({
      card: params[:stripeToken],
      email: params[:user][:email]
    }).create_customer
  end

  def charge_with_credit_card_service(user)
    CreditCardService.new({
      customer: user.external_customer_id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    }).charge
  end

  def add_customer_id_to_user(id)
    @user.update_attributes(external_customer_id: id)
  end
end
