require 'rails_helper'

RSpec.describe User::RegistrationsController, type: :controller do

  describe "GET #new" do
    it "does not exist for anyone" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect{ get :new }.to raise_error{ ActionController::RoutingError } 
    end
  end

  describe "GET #create" do
    it "does not exist for anyone" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect{ get :create, FactoryGirl.build(:user).attributes }.to raise_error{ ActionController::RoutingError }
      login_user
      expect{ get :create, FactoryGirl.build(:user).attributes }.to raise_error{ ActionController::RoutingError }
    end
  end

  describe "GET #list" do
    it "fails when not logged in" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect{ get :list }.to raise_error{ ActionController::RoutingError }
    end

    it "succeeds with HTTP 200 when logged in as admin" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      login_user
      get :list
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #edit" do
    it "fails for everyone" do
      !request.env["devise.mapping"] = Devise.mapping[:user]
      expect{ get :edit, :username => user.username }.to raise_error{ ActionController::RoutingError }
      login_user
      expect{ get :edit, :username => user.username }.to raise_error{ ActionController::RoutingError }
    end
  end

  describe "POST #submit_edit" do
    it "fails for everyone" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = get_example_user
      expect{ post :submit_edit, :username => user.username, 
		:edit => { :username => "new_username" } }.to raise_error{ ActionController::RoutingError }
      login_user
      
      expect{ post :submit_edit, :username => user.username, 
		:edit => { :username => "new_username" } }.to raise_error{ ActionController::RoutingError }
    end
  end

  private
    def login_user 
      user = User.new(:email => "email@email.com", 
			:username => "user",
			:password => "password",
			:password_confirmation => "password" )
      user.save
      sign_in(user)
      return user
    end

  private
    def get_example_user
      user = User.new(:email => "someother@email.com",
			:username => "someotheruser",
			:password => "password",
			:password_confirmation => "password",
			:admin => false)
      user.save
      return user
    end
end

