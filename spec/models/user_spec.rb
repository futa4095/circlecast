# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'name' do
    it '空文字の場合、無効であること' do
      user = User.new(name: '', email: 'test@example.com', password: 'password')
      expect(user.valid?).to be(false)
      expect(user.errors[:name]).to include('を入力してください')
    end
  end
end
