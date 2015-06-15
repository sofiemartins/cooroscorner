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
    it "logges in user" do
      assert !current_user
      user = get_example_user
      post :create, :login => { :username => user.username,
				:password => "password" }
      assert !!current_user
    end
  end

  private 
    def get_example_user
      user = User.new(:email => "email@email.com",
			:username => "user",
			:password => "password",
			:passsword_confirmation => "password")
      user.save
    end

end
