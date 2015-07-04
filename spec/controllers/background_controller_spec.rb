require 'rails_helper'

RSpec.describe BackgroundController, type: :controller do

  describe "GET #new" do
    it "returns not found when not logged in" do
      expect{ get :new }.to raise_error{ActionController::RoutingError}
    end

    it "returns found when logged in as normal user" do
      setup_user
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders template when logged in as admin" do
      setup_user
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #create" do
    it "returns not found when not logged in" do
      expect{ post :create, :background => { :label => "label", :image => nil }}.to raise_error{ ActionController::RoutingError }
    end

    it "creates a new background successfully when logged in as admin" do
      setup_user
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

    it "succeeds with HTTP 200 when logged in as admin" do
      setup_user
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

    it "submits successfully when logged in as admin" do
      setup_user
      background = Background.new(:label => "background1")
      assert background.save
      assert !!Background.find_by(:label => "background1")
      assert !Background.find_by(:label => "background100")
      new_attributes = FactoryGirl.build(:background).attributes
      post :submit_edit, :label => background.label, :edit => new_attributes 
      expect(response).to have_http_status(302)
      assert_redirected_to "/list/backgrounds" 
      assert Background.find_by(:label => "background100")
      assert !Background.find_by(:label => "background1")
    end

    it "changes all corresponding categories, when background label is changed" do
      setup_user
      background = Background.new(:label => "background")
      assert background.save
      category = Category.new(:label => "category", :short => "cat", :background => background.label)
      assert category.save

      assert Category.where(:background => "background").count == 1
      assert !Category.find_by(:background => "background100")

      new_attributes = FactoryGirl.build(:background).attributes 
      post :submit_edit, :label => background.label, :edit => new_attributes

      assert !Category.find_by(:background => "background")
      assert Category.where(:background => "background100").count == 1
    end
  end

  describe "GET #destroy" do
    it "returns not found when not logged in" do
      background = get_example_background
      expect{ get :destroy, :label => background.label}.to raise_error{ ActionController::RoutingError }
    end

    it "succeeds when logged in as admin and redirects to /list/backgrounds" do
      setup_user
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

    it "succeeds when logged in as admin with HTTP 200" do
      setup_user
      get :list 
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  private
    def setup_user
      user = User.new(email: "email@email.com", username: "user",
		password: "password", password_confirmation: "password" )
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
