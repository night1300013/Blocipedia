require 'rails_helper'
require 'spec_helper'

RSpec.describe ChargesController, type: :controller do
  let(:my_user) { create(:user, role: 'premium') }
  before do
    sign_in(my_user)
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    # it "instantiate @charge" do
    #   get :new
    #   expect(assigns(:charge)).not_to be_nil
    # end
  end
end
