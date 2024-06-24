# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group do
  let(:user) { User.create(email: 'test@example.com', password: 'password', name: 'test user') }

  describe 'name' do
    context 'when it is empty' do
      it 'is invalid' do
        group = described_class.new(name: '')
        expect(group.valid?).to be(false)
        expect(group.errors[:name]).to include('を入力してください')
      end
    end
  end

  describe '#add_member' do
    it 'adds a member to the group' do
      group = described_class.create(name: 'test group')
      group.add_member user

      expect(group.users).to include user
      expect(user.groups).to include group
    end
  end

  describe '#withdraw_member' do
    it 'updates withdrawal to true' do
      group = described_class.create(name: 'test group')
      group.users << user
      group.withdraw_member user

      membership = group.memberships.find_by(user:)
      expect(membership.withdrawal).to be_truthy
    end
  end

  describe 'associations' do
    let(:group) { described_class.create(name: 'test group') }

    context 'when destroyed' do
      it 'destroys associated memberships' do
        group.users << user
        expect { group.destroy }.to change(Membership, :count).by(-1)
      end

      it 'destroys associated channels' do
        Channel.create(title: 'test channel', group:)
        expect { group.destroy }.to change(Channel, :count).by(-1)
      end

      it 'destroys associated invitation' do
        Invitation.create(group:, token: 'abcdef')
        expect { group.destroy }.to change(Invitation, :count).by(-1)
      end
    end
  end

  describe '#admin?' do
    let(:group) { described_class.create(name: 'test group') }

    context 'when the user is an admin' do
      it 'returns true' do
        group.memberships.create(user:, admin: true)
        expect(group.admin?(user)).to be true
      end
    end

    context 'when the user is not an admin' do
      it 'returns false' do
        group.memberships.create(user:, admin: false)
        expect(group.admin?(user)).to be false
      end
    end

    context 'when the user is not a member of the group' do
      it 'returns nil' do
        expect(group.admin?(user)).to be_nil
      end
    end
  end

  describe '#only_one_admin?' do
    context 'when there is only one admin' do
      it 'returns true' do
        group = described_class.create(name: 'test group')
        group.memberships.create(user:, admin: true)
        withdrawn_user = User.create(email: 'withdrawn@example.com', password: 'password', name: 'withdrawn user')
        group.memberships.create(user: withdrawn_user, admin: true, withdrawal: true)

        expect(group).to be_only_one_admin
      end
    end

    context 'when there are two admins' do
      it 'returns false' do
        group = described_class.create(name: 'test group')
        group.memberships.create(user:, admin: true)
        second_user = User.create(email: 'second@example.com', password: 'password', name: 'second user')
        group.memberships.create(user: second_user, admin: true)

        expect(group).not_to be_only_one_admin
      end
    end
  end

  describe '#recent_episodes' do
    it 'orders group episodes by creation date in descending order' do
      group = described_class.create(name: 'test group')
      group.memberships.create(user:, admin: true)
      channel = group.channels.create(title: 'test channel')
      5.times do |i|
        channel.episodes.create(title: "episode #{i}", enclosure: fixture_file_upload('audio1.m4a', 'audio/mp4'))
      end

      expect(group.recent_episodes.size).to eq 5
      expect(group.recent_episodes.first.title).to eq 'episode 4'
      expect(group.recent_episodes.last.title).to eq 'episode 0'
    end

    it 'retrieves episodes from multiple channels in the group' do
      group = described_class.create(name: 'test group')
      group.memberships.create(user:, admin: true)
      2.times do |i|
        channel = group.channels.create(title: "test channel #{i}")
        channel.episodes.create(title: "episode ch #{i}", enclosure: fixture_file_upload('audio1.m4a', 'audio/mp4'))
      end

      expect(group.recent_episodes.size).to eq 2
      expect(group.recent_episodes.first.channel.title).to eq 'test channel 1'
      expect(group.recent_episodes.last.channel.title).to eq 'test channel 0'
    end
  end

  describe '#icon_url' do
    let(:group) { described_class.create(name: 'test group') }

    context 'when icon is attached' do
      it 'returns the icon' do
        group.icon.attach(io: Rails.root.join('spec/fixtures/files/icon1.png').open,
                          filename: 'icon1.png', content_type: 'image/png')

        expect(group.icon_url).to eq(group.icon)
      end
    end

    context 'when icon is not attached' do
      it 'returns the default icon URL' do
        expect(group.icon_url).to eq('default-group.svg')
      end
    end
  end

  describe '#icon_alt' do
    let(:group) { described_class.create(name: 'test group') }

    context 'when icon is attached' do
      it 'returns the icon alt text with the name' do
        group.icon.attach(io: Rails.root.join('spec/fixtures/files/icon1.png').open,
                          filename: 'icon1.png', content_type: 'image/png')

        expect(group.icon_alt).to eq('test groupのアイコン')
      end
    end

    context 'when icon is not attached' do
      it 'returns the default icon alt text' do
        expect(group.icon_alt).to eq('グループのアイコン')
      end
    end
  end
end
