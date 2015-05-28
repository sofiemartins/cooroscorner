require 'rails_helper'

RSpec.describe CategoryController, type: :controller do

  describe "GET #category" do
    it "will fail when admin isn't authenticated" do
      expect{ get :show }.to raise_error{ActionController::RoutingError}
    end
  end

end
