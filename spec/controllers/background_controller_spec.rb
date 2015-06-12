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

  describe "GET #create" do
    it "returns not found when not logged in" do
      expect{ post :create, :background => { :label => "label", :image => nil }}.to raise_error{ ActionController::RoutingError }
    end

    it "returns not found when logged in as normal user" do
      setup_user
      expect{ post :create, :background => { :label => "label", :image => nil }}.to raise_error{ ActionController::RoutingError }
    end

    it "creates a new background successfully when logged in as admin" do
      setup_admin
      post :create, :background => { :label => "label", :image => nil }
      expect(response).to have_http_status(302)
      assert_redirected_to "/background"
    end
  end

  describe "GET #edit" do
    it "returns not found when not logged in" do
      background = get_example_background
      expect{ get :edit, :label => background.label }.to raise_error{ ActionController::RoutingError }
    end

    it "returns not found when logged in as normal user" do
      setup_user
      background = get_example_background
      expect{ get :edit, :label => background.label}.to raise_error{ ActionController::RoutingError }
    end

    it "succeeds with HTTP 200 when logged in as admin" do
      setup_admin
      background = get_example_background
      get :edit, :label => background.label
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #submit_edit" do
    it "returns not found when not logged in" do
      background = get_example_background
      expect{ post :submit_edit, :label => background.label, :edit => FactoryGirl.build(:background).attributes}.to raise_error{ ActionController::RoutingError } 
    end

    it "returns not found when not logged in" do
      setup_user
      background = get_example_background
      expect{ post :submit_edit, :label => background.label, :edit => FactoryGirl.build(:background).attributes}.to raise_error{ ActionController::RoutingError }
    end

    it "submits successfully when logged in as admin" do
      setup_admin
      background = get_example_background
      new_attributes = FactoryGirl.build(:background).attributes
      new_background = FactoryGirl.create(:background)
      post :submit_edit, :label => background.label, :edit => new_attributes 
      expect(response).to have_http_status(302)
      assert_redirected_to background_path
      assert background.label == new_background.label
    end
  end

  describe "GET #destroy" do
    it "returns not found when not logged in" do
      background = get_example_background
      expect{ get :destroy, :label => background.label}.to raise_error{ ActionController::RoutingError }
    end

    it "returns not found when logged in as normal user" do
      setup_user
      background = get_example_background
      expect{ get :destroy, :label => background.label}.to raise_error{ ActionController::RoutingError }
    end
   
    it "succeeds when logged in as admin and redirects to /list/backgrounds" do
      setup_admin
      background = get_example_background
      get :destroy, :label => background.label
      expect(response).to have_http_status(302)
      assert_redirected_to "/list/backgrounds"
    end
  end

  describe "GET #list" do
    it "returns not found when not logged in" do
      expect{ get :list }.to raise_error{ ActionController::RoutingError }
    end

    it "returns not found when logged in as normal user" do
      setup_user
      expect{ get :list }.to raise_error{ ActionController::RoutingError }
    end

    it "succeeds when logged in as admin with HTTP 200" do
      setup_admin
      get :list 
      expect(response).to be_success
      expect(response).to have_http_status(200)
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

  private
    def get_example_background
      background = Background.new(:label => "label")
      background.save
      return background
    end

end
