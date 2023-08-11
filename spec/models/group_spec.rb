# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'name' do
    it '空文字の場合、無効であること' do
      group = Group.new(name: '')
      expect(group.valid?).to be(false)
      expect(group.errors[:name]).to include('を入力してください')
    end
  end
end
