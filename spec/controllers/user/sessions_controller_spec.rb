require 'rails_helper'

RSpec.describe User::SessionsController, type: :controller do

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
    it "signs in user and redirects to root" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = get_example_user
      post :create, :session => { :username => user.username, :password => "password" }
      expect(response).to have_http_status(302)
      assert_redirected_to root_path
      get :destroy
      expect(response).to have_http_status(302)
      assert_redirected_to root_path
    end
  end

  private 
    def get_example_user
      user = User.new(:email => "email@email.com",
			:username => "user",
			:password => "password",
			:password_confirmation => "password")
      user.save
      return user
    end

end
