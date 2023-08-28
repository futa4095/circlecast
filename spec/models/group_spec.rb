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

  describe '#add_member' do
    it 'グループにメンバーを追加すること' do
      group = Group.create(name: 'test group')
      user = User.create(email: 'test@example.com', password: 'password', name: 'test user')
      group.add_member user

      expect(group.users).to include user
      expect(user.groups).to include group
    end
  end

  describe '#withdraw_member' do
    it 'withdrawalをtrueに更新すること' do
      group = Group.create(name: 'test group')
      user = User.create(email: 'test@example.com', password: 'password', name: 'test user')
      group.users << user
      group.withdraw_member user

      membership = group.memberships.find_by(user:)
      expect(membership.withdrawal).to be_truthy
    end
  end
end
