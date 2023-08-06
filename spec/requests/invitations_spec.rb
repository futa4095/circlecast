require 'rails_helper'

RSpec.describe "Invitations", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/invitations/show"
      expect(response).to have_http_status(:success)
    end
  end

end
