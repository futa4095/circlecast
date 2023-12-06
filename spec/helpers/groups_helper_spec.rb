# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsHelper do
  describe 'description_too_long?' do
    it 'descriptionが短い場合, falseになること' do
      short_description = <<~DESCRIPTION
        one
        two
        three
        four
        five
        six
      DESCRIPTION
      expect(description_too_long?(short_description)).to be_falsy
    end

    it 'descriptionが長い場合, trueになること' do
      long_description = <<~DESCRIPTION
        one
        two
        three
        four
        five
        six
        seven
      DESCRIPTION
      expect(description_too_long?(long_description)).to be_truthy
    end
  end
end
