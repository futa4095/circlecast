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

  describe '#active_participating_groups' do
    it '参加しているグループを取得すること' do
      user = User.create(name: 'test', email: 'test@example.com', password: 'password')
      active_group = Group.create(name: 'active group')
      active_group.add_member user

      inactive_group = Group.create(name: 'inactive group')
      inactive_group.add_member user
      inactive_group.withdraw_member user

      active_groups = user.active_participating_groups
      expect(active_groups.size).to eq 1
      expect(active_groups[0].name).to eq active_group.name
    end
  end
end
