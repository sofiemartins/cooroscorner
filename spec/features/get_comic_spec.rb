require 'rails_helper'

  $allcategories = [ "offensive", "random", "mayuyu", "tina", "alice" ]

  feature "GET show_last" do
    scenario "test" do
      visit "login"
      expect(response).to have_http_status(200)
    end

    scenario "gets with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        visit "/#{category}"
        expect(response).to have_http_status(302)
        follow_redirect!
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  feature "GET show" do
    scenario "gets with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        get :show_last, :category => category
        expect(response).to have_http_status(302)
      end
    end

    scenario "renders template for every category" do
      $allcategories.each do |category|
        get :show, :category => category, :index => '1'
        expect(response).to render_template("show") 
      end
    end
  end

  feature "GET back" do
    scenario "gets back with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        get "/back/#{category}/1"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

    scenario "renders template after the back path" do
      $allcategories.each do |category|
        get "/back/#{category}/1"
        expect(response).to render_template("show")
      end
    end
  end

  feature "GET next" do
    scenario "gets next with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        get "/next/#{category}/1"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    scenario "renders the template after the next redirect" do
      $allcategories.each do |category|
        get "/next/#{category}/1"
        expect(response).to render_template("show")
      end
    end
  end

  feature "GET random" do
    scenario "gets random with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        get "/random/#{category}/1"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    scenario "renders template after random redirect" do
      $allcategories.each do |category|
        get "/random/#{category}/1"
        expect(response).to render_template("show")
      end
    end
  end
end
