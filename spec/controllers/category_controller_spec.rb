require 'rails_helper'

RSpec.describe CategoryController, type: :controller do

  describe "GET #new" do
    it "will fail when not logged in" do
      expect{ get :new }.to raise_error{ ActionController::RoutingError }
    end

    it "raises not found, when user is logged in" do
      login_user
      expect{ get :new }.to raise_error{ ActionController::RoutingError }  
    end

    it "renders successfully with http 200, when logged in as admin" do
      login_admin
       get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
 
  describe "POST #create" do
    it "will fail when not logged in" do
      expect{ post :create, :category => FactoryGirl.build(:category).attributes }.to raise_error{ ActionController::RoutingError }
    end

    it "will fail when logged in as normal user" do
      login_user
      expect{ post :create, :category => FactoryGirl.build(:category).attributes }.to raise_error{ ActionController::RoutingError } 
    end

    it "will succeed when logged in as admin" do
      login_admin
      post :create, :category => FactoryGirl.build(:category).attributes
      expect(response).to have_http_status(302)
      assert_redirected_to "/category"
    end
  end

  describe "GET #edit" do
    it "will fail when not logged in" do
      category = get_example_category
      expect{ get :edit, :short => category.short }.to raise_error{ ActionController::RoutingError }
    end

    it "will fail for any normal user that is logged in" do
      login_user
      category = get_example_category
      expect{ get :edit, :short => category.short }.to raise_error{ ActionController::RoutingError }
    end

    it "will succeed, when an admin is logged in" do
      login_admin
      category = get_example_category
      get :edit, :short => category.short
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #submit_edit" do
    it "fails when not logged in" do
      category = get_example_category
      expect{ get :submit_edit, :short => category.short, :category => FactoryGirl.build(:category).attributes }.to raise_error{ ActionController::RoutingError }
    end

    it "fails when logged in as normal user" do
      login_user
      category = get_example_category
      expect{ get :submit_edit, :short => category.short, :category => FactoryGirl.build(:category).attributes }.to raise_error{ ActionController::RoutingError } 
    end

    it "fails when logged in as admin" do
      login_admin
      category = get_example_category
      new_attributes = FactoryGirl.build(:category).attributes
      new_short = FactoryGirl.create(:category).short
      get :submit_edit, :short => category.short, :edit => new_attributes 
      expect(response).to have_http_status(302)
      assert_redirected_to "/#{new_short}"
    end
  end

  describe "GET #destroy" do
    it "fails when not logged in" do
      category = get_example_category
      expect{ get :destroy, :short => category.short }.to raise_error{ ActionController::RoutingError }
    end

    it "fails when user loggend in" do
      login_user
      category = get_example_category
      expect{ get :destroy, :short => category.short }.to raise_error{ ActionController::RoutingError }
    end

    it "succeeds when logged in as admin" do
      login_admin
      category = get_example_category
      get :destroy, :short => category.short
      expect(response).to have_http_status(302)
      assert_redirected_to root_path
    end
  end

  describe "GET #list" do
    it "fails when not logged in" do
      expect{ get :list }.to raise_error{ ActionController::RoutingError }
    end

    it "fails when logged in as normal user" do
      login_user
      expect{ get :list }.to raise_error{ ActionController::RoutingError }
    end

    it "succeeds when logged in as admin" do
      login_admin
      get :list
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  def login_user
    user = User.new(email: "email@email.com", username: "user",
			password: "password",
			password_confirmation: "password",
			admin: false)
    user.save
    sign_in(user)
  end

  def login_admin
    admin = User.new(email: "email@email.com", username: "admin",
			password: "password",
			password_confirmation: "password",
			admin: true)
    admin.save
    sign_in(admin)
  end

  def get_example_category
    category = Category.new(label: "label",
				short: "short")
    category.save
    return category
  end

end
