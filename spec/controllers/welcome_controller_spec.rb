require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let (:user) { User.create!(email: "1234@12.12", password: "1234567") }
  describe "GET index" do
    before do
      sign_in user
    end
    it "renders the index template" do

      get :index
      expect(response).to render_template("index")
    end
  end
end
