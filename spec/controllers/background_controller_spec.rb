require 'rails_helper'

RSpec.describe BackgroundController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      setup_admin
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  def setup_admin
    user = User.new(email: "email@email.com", username: "admin", 
			password: "password", password_confirmation: "password",
			admin: true)
    user.save
    sign_in(user)
  end

end
