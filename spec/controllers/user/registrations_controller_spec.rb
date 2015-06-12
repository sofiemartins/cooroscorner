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

  describe "GET #list" do
    it "fails when not logged in" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect{ get :list }.to raise_error{ ActionController::RoutingError }
    end

    it "fails when logged in as normal user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      login_user
      expect{ get :list }.to raise_error{ ActionController::RoutingError }
    end

    it "succeeds with HTTP 200 when logged in as admin" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      login_admin
      get :list
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #edit" do
    it "fails when not logged in" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = get_example_user
      expect{ get :edit, :username => user.username }.to raise_error{ ActionController::RoutingError }
    end

    it "fails when a normal user is logged in that has not the same username as the target user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      login_user
      user = get_example_user
      expect{ get :edit, :username => user.username }.to raise_error{ ActionController::RoutingError }
    end

    it "succeeds if the logged in user has the same username as the target user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = login_user
      puts user.username
      get :edit, :username => user.username
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "succeeds when logged in as admin" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      login_admin
      user = get_example_user
      puts user.username
      get :edit, :username => user.username
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  private
    def login_user 
      user = User.new(:email => "email@email.com", 
			:username => "user",
			:password => "password",
			:password_confirmation => "password",
			:admin => false)
      user.save
      sign_in(user)
      return user
    end

  private
    def login_admin
      admin = User.new(:email => "email@email.com",
			:username => "admin",
			:password => "password",
			:password_confirmation => "password",
			:admin => true)
      admin.save
      sign_in(admin)
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

