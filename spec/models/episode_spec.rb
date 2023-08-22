# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Episode, type: :model do
  let(:group) { Group.create(name: 'Test Group') }
  let(:channel) { Channel.create(title: 'Test Channel', group:) }

  describe '#updated?' do
    it 'returns true if the episode was updated' do
      episode = Episode.create(title: 'Test Episode', channel:,
                               enclosure: fixture_file_upload('audio1.m4a', 'audio/mp4'))
      expect(episode.updated?).to be(false)

      travel 1.day
      episode.update(title: 'Updated Test Episode')
      expect(episode.updated?).to be(true)
    end
  end
end
