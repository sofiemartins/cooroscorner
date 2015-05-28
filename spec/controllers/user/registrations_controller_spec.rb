require 'rails_helper'

RSpec.describe User::RegistrationsController, type: :controller do

  describe "GET #new" do
    it "responds successfully with an HTTP 200 code" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #create" do
    it "creates a user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, FactoryGirl.build(:user).attributes
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "redirects to root and renders root template" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, FactoryGirl.build(:user).attributes
      expect(response).to render_template("/")
    end
  end

end

