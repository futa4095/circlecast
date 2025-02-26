# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel do
  describe 'title' do
    context 'when it is empty' do
      it 'is invalid' do
        channel = described_class.new(title: '')
        expect(channel.valid?).to be(false)
        expect(channel.errors[:title]).to include('を入力してください')
      end
    end

    context 'when it is duplicated within the same group' do
      let(:group) { Group.create(name: 'test group') }

      it 'is invalid' do
        described_class.create(title: 'test channel', group: group)
        channel = described_class.new(title: 'test channel', group: group)
        expect(channel.valid?).to be(false)
        expect(channel.errors[:title]).to include('はすでに存在します')
      end
    end

    context 'when it is duplicated in different groups' do
      let(:source_group) { Group.create(name: 'source group') }
      let(:target_group) { Group.create(name: 'target group') }

      it 'is valid' do
        described_class.create(title: 'test channel', group: source_group)
        channel = described_class.new(title: 'test channel', group: target_group)
        expect(channel.valid?).to be(true)
      end
    end
  end

  describe 'associations' do
    let(:group) { Group.create(name: 'test group') }
    let(:channel) { described_class.create(title: 'test channel', group:) }

    context 'when destroyed' do
      it 'destroys associated channels' do
        channel.episodes.create(title: 'test episode', enclosure: fixture_file_upload('audio1.m4a', 'audio/mp4'))
        expect { channel.destroy }.to change(Episode, :count).by(-1)
      end
    end
  end

  describe '#artwork_url' do
    let(:group) do
      Group.create(name: 'test group')
    end
    let(:channel) do
      described_class.create(title: 'test channel', group:)
    end

    context 'when artwork is attached' do
      it 'returns the artwork' do
        channel.artwork.attach(io: Rails.root.join('spec/fixtures/files/artwork1.png').open,
                               filename: 'artwork1.png', content_type: 'image/png')

        expect(channel.artwork_url).to eq(channel.artwork)
      end
    end

    context 'when artwork is not attached' do
      it 'returns the default artwork URL' do
        expect(channel.artwork_url).to eq('default-channel.svg')
      end
    end
  end

  describe '#artwork_alt' do
    let(:group) { Group.create(name: 'test group') }
    let(:channel) { described_class.create(title: 'test channel', group:) }

    context 'when artwork is attached' do
      it 'returns the artwork alt text with the title' do
        channel.artwork.attach(io: Rails.root.join('spec/fixtures/files/artwork1.png').open,
                               filename: 'artwork1.png', content_type: 'image/png')

        expect(channel.artwork_alt).to eq('test channelのアートワーク')
      end
    end

    context 'when artwork is not attached' do
      it 'returns the default artwork alt text' do
        expect(channel.artwork_alt).to eq('番組のアートワーク')
      end
    end
  end
end
