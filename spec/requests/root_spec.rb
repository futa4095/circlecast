# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roots', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /terms' do
    it 'returns http success' do
      get '/terms'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /privacy' do
    it 'returns http success' do
      get '/privacy'
      expect(response).to have_http_status(:success)
    end
  end
end
