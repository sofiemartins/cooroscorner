require 'rails_helper'

RSpec.describe BackgroundController, type: :controller do

  describe "GET #new" do
    it "returns not found when not logged in" do
      expect{ get :new }.to raise_error{ActionController::RoutingError}
    end

    it "returns not found when logged in as normal user" do
      setup_user
      expect{ get :new }.to raise_error{ActionController::RoutingError}
    end

    it "returns http success when logged in as admin" do
      setup_admin
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders template when logged in as admin" do
      setup_admin
      get :new
      expect(response).to render_template("new")
    end
  end

  private
    def setup_admin
      user = User.new(email: "email@email.com", username: "admin", 
  		password: "password", password_confirmation: "password",
		admin: true)
      user.save
      sign_in(user)
    end

  private
    def setup_user
      user = User.new(email: "email@email.com", username: "user",
		password: "password", password_confirmation: "password",
		admin: false)
      user.save
      sign_in(user)
    end

end
