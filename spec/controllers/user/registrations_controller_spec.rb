require 'rails_helper'

RSpec.describe User::RegistrationsController, type: :controller do

  describe "GET #new" do
    it "responds successfully with an HTTP 200 code" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #create" do
    it "creates a user and redirects to root" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      testuser = FactoryGirl.create :user
      post :create, testuser
      expect(response).to be_success
    end
  end

end
