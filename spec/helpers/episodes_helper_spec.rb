# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EpisodesHelper do
  describe '#publication_and_update_dates' do
    let(:created_at) { Time.zone.local(2024, 5, 1) }
    let(:updated_at) { Time.zone.local(2024, 5, 20) }

    let(:episode) { instance_double(Episode, created_at:, updated_at:, updated?: updated?) }

    before do
      allow(helper).to receive(:l).and_return(I18n.l(created_at.to_date), I18n.l(updated_at.to_date))
    end

    context 'when the episode is not updated' do
      let(:updated?) { false }

      it 'returns the publication date only' do
        expect(helper.publication_and_update_dates(episode)).to eq('2024/05/01に公開')
      end
    end

    context 'when the episode is updated' do
      let(:updated?) { true }

      it 'returns the publication date and the updated date' do
        expect(helper.publication_and_update_dates(episode)).to(
          eq('2024/05/01に公開 (2024/05/20に更新)')
        )
      end
    end
  end
end
