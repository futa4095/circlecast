# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group do
  let(:user) { User.create(email: 'test@example.com', password: 'password', name: 'test user') }

  describe 'name' do
    it '空文字の場合、無効であること' do
      group = described_class.new(name: '')
      expect(group.valid?).to be(false)
      expect(group.errors[:name]).to include('を入力してください')
    end
  end

  describe '#add_member' do
    it 'グループにメンバーを追加すること' do
      group = described_class.create(name: 'test group')
      group.add_member user

      expect(group.users).to include user
      expect(user.groups).to include group
    end
  end

  describe '#withdraw_member' do
    it 'withdrawalをtrueに更新すること' do
      group = described_class.create(name: 'test group')
      group.users << user
      group.withdraw_member user

      membership = group.memberships.find_by(user:)
      expect(membership.withdrawal).to be_truthy
    end
  end

  describe 'associations' do
    let(:group) { described_class.create(name: 'test group') }

    it 'destroys associated memberships when destroyed' do
      group.users << user
      expect { group.destroy }.to change(Membership, :count).by(-1)
    end

    it 'destroys associated channels when destroyed' do
      Channel.create(title: 'test channel', group:)
      expect { group.destroy }.to change(Channel, :count).by(-1)
    end

    it 'destroys associated invitation when destroyed' do
      Invitation.create(group:, token: 'abcdef')
      expect { group.destroy }.to change(Invitation, :count).by(-1)
    end
  end

  describe '#admin?'

  describe '#only_one_admin?' do
    it '管理者が1人の場合, trueになること' do
      group = described_class.create(name: 'test group')
      group.memberships.create(user:, admin: true)
      withdrawn_user = User.create(email: 'withdrawn@example.com', password: 'password', name: 'withdrawn user')
      group.memberships.create(user: withdrawn_user, admin: true, withdrawal: true)

      expect(group).to be_only_one_admin
    end

    it '管理者が2人の場合, falseになること' do
      group = described_class.create(name: 'test group')
      group.memberships.create(user:, admin: true)
      second_user = User.create(email: 'second@example.com', password: 'password', name: 'second user')
      group.memberships.create(user: second_user, admin: true)

      expect(group).not_to be_only_one_admin
    end
  end

  describe '#recent_episodes' do
    it 'グループのエピソードが作成日時の降順になること' do
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

    it 'グループの複数番組のエピソードが取得できること' do
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
end
