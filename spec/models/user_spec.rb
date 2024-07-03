# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'name' do
    context 'when it is empty' do
      it 'is invalid' do
        user = described_class.new(name: '', email: 'test@example.com', password: 'password')
        expect(user.valid?).to be(false)
        expect(user.errors[:name]).to include('を入力してください')
      end
    end
  end

  describe '#groups' do
    it 'retrieves the groups the user is participating in' do
      user = described_class.create(name: 'test', email: 'test@example.com', password: 'password')
      active_group = Group.create(name: 'active group')
      active_group.add_member user

      inactive_group = Group.create(name: 'inactive group')
      inactive_group.add_member user
      inactive_group.withdraw_member user

      active_groups = user.groups
      expect(active_groups.size).to eq 1
      expect(active_groups[0].name).to eq active_group.name
    end
  end

  describe '#channels' do
    it 'etrieves the channels from the groups the user is participating in' do
      user = described_class.create(name: 'test', email: 'test@example.com', password: 'password')
      active_group = Group.create(name: 'active group')
      active_group.add_member user
      active_group.channels.create(title: 'active channel')

      inactive_group = Group.create(name: 'inactive group')
      inactive_group.add_member user
      inactive_group.withdraw_member user
      inactive_group.channels.create(title: 'inactive channel')

      active_channels = user.channels
      expect(active_channels.size).to eq 1
      expect(active_channels[0].title).to eq 'active channel'
    end
  end
end
