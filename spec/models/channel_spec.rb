# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel do
  describe 'title' do
    it '空文字の場合、無効であること' do
      channel = described_class.new(title: '')
      expect(channel.valid?).to be(false)
      expect(channel.errors[:title]).to include('を入力してください')
    end
  end

  describe 'associations' do
    let(:group) { Group.create(name: 'test group') }
    let(:channel) { described_class.create(title: 'test channel', group:) }

    it 'destroys associated channels when destroyed' do
      channel.episodes.create(title: 'test episode', enclosure: fixture_file_upload('audio1.m4a', 'audio/mp4'))
      expect { channel.destroy }.to change(Episode, :count).by(-1)
    end
  end
end
