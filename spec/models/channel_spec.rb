require 'rails_helper'

RSpec.describe Channel, type: :model do
  describe 'title' do
    it '空文字の場合、無効であること' do
      channel = Channel.new(title: '')
      expect(channel.valid?).to be(false)
      expect(channel.errors[:title]).to include('を入力してください')
    end
  end
end
