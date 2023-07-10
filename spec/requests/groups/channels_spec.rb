require 'rails_helper'

RSpec.describe "Groups::Channels", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/groups/channels/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/groups/channels/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/groups/channels/create"
      expect(response).to have_http_status(:success)
    end
  end

end
