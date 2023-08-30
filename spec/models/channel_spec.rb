# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel, type: :model do
  describe 'title' do
    it '空文字の場合、無効であること' do
      channel = Channel.new(title: '')
      expect(channel.valid?).to be(false)
      expect(channel.errors[:title]).to include('を入力してください')
    end
  end

  describe 'associations' do
    let(:group) { Group.create(name: 'test group') }
    let(:channel) { Channel.create(title: 'test channel', group:) }
    let!(:episode) do
      Episode.create(title: 'test episode', channel:, enclosure: fixture_file_upload('audio1.m4a', 'audio/mp4'))
    end

    it 'destroys associated channels when destroyed' do
      expect { channel.destroy }.to change(Episode, :count).by(-1)
    end
  end
end
