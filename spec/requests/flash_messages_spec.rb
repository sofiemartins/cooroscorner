require 'rails_helper'

RSpec.describe "FlashMessages", type: :request do
  describe "login" do
    it "flashs alert when invalid username/password combination" do
      post "/login", :session => { :username => "user", :password => "password" }
      expect(flash[:alert]).to be_present 
    end

    it "flash vanishes after a new page is loaded" do
      post "/login", :session => { :username => "user", :password => "password"}
      reload
      expect(flash[:alert]).to be_nil
    end

    it "flashs notice when valid username/password combination" do
      setup_user
      post "/login", :session => { :username => "user", :password => "password" }
      expect(flash[:notice]).to be_present
    end

    it "flash vanished after a new page is loaded for valid login" do
      setup_user
      post "/login", :session => { :username => "user", :password => "password" }
      reload
      expect(flash[:notice]).to be_nil
    end
  end

  describe "logout" do
    it "flashs when user has been logged out" do
      setup_user
      post "/login", :session => { :username => "user", :password => "password" }
      get "/logout"
      expect(flash[:notice]).to be_present
    end

    it "does not flash after reload" do
      setup_user
      post "/login", :session => { :username => "user", :password => "password" }
      get "/logout"
       reload
      expect(flash[:notice]).to be_nil
    end
  end

  describe "create background" do
    it "flashs alert when invalid data has been submitted" do
      setup_background("")
      expect(flash[:alert]).to be_present
    end

    it ", flash vanishes after reload when invalid input" do
      setup_background("")
      reload
      expect(flash[:alert]).to be_nil
    end

    it "flashs notice when the background has been created successfully" do
      setup_background("label")
      expect(flash[:success]).to be_present
    end

    it ", flash vanishes after reload when successfully created" do
      setup_background("label")
      reload
      expect(flash[:success]).to be_nil
    end
  end

  describe "edit background" do
    it "flashs alert when changes are unsuccessful" do
      perform_background_edit("")
      expect(flash[:alert]).to be_present
    end

    it ", flash vanishes after unsuccessful edit and reload" do
      perform_background_edit("")
      reload
      expect(flash[:alert]).to be_nil
    end

    it  "flashs success when changes are successful" do
      perform_background_edit("validlabel")
      expect(flash[:success]).to be_present
    end

    it  ", flash vanishes after successful edit and reload" do
      perform_background_edit("validlabel")
      reload
      expect(flash[:success]).to be_nil
    end
  end

  describe "create category" do
    it "flashs alert when changes are unsuccessful" do
      setup_category("")  
      expect(flash[:alert]).to be_present
    end

    it ", flash vanishes after reload after being not successful" do
      setup_category("")
      reload
      expect(flash[:alert]).to be_nil
    end

    it "flashs successful when changes are successful" do
      setup_category("validabbr")
      expect(flash[:success]).to be_present
    end

    it ", flash vanishes after reload after success" do
      setup_category("validabbr")
      reload
      expect(flash[:success]).to be_nil
    end
  end

  describe "edit category" do
    it "flashs alert when changes are unsuccessful" do
      perform_category_edit("")
      expect(flash[:alert]).to be_present
    end

    it ", flash vanishes after reload and unsuccessful change" do
      perform_category_edit("")
      reload
      expect(flash[:alert]).to be_nil
    end

    it "flashs success when changes are successful" do
      perform_category_edit("newvalid")
      expect(flash[:success]).to be_present
    end
 
    it ", flash vanishes after successful change and reload" do
      perform_category_edit("newvalid")
      reload 
      expect(flash[:success]).to be_nil
    end
  end

  private 
    def perform_background_edit(new_label)
      background = setup_background("somelabel")
      post "/edit/background/#{background.label}", :edit => { :label => new_label }
    end

  private 
    def perform_category_edit(new_short)
      category = setup_category("valid")
      post "/edit/category/#{category.short}", :edit => { :short => new_short }
    end

  private
    def setup_user
      user = User.new(:email => "email@email.com", :username => "user", 
			:password => "password",
			:password_confirmation => "password")
      user.save
    end

  private
    def setup_background(label)
      login_user
      background = Background.new(:label => label)
      post "/background", :background => { :label => background.label } 
      return background
    end

  private
    def setup_category(short)
      login_user
      category = Category.new(:label => "some label", :short => short)
      post "/category", :category => { :label => category.label, :short => category.short }
      return category
    end

  private 
    def login_user
      setup_user
      post "/login", :session => { :username => "user", :password => "password" } 
    end
  
  private 
    def reload
      get "/"
      get "/"
    end

end
