# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Groups::MembersHelper do
  describe '#toggle_button'
  describe '#toggle_button_class' do
    it 'returns the appropriate class when active is true' do
      expect(helper.toggle_button_class(true)).to include('bg-blue-700')
    end

    it 'returns the appropriate class when active is false' do
      expect(helper.toggle_button_class(false)).to include('bg-gray-200')
    end
  end

  describe '#toggle_span_class' do
    it 'returns the appropriate class when active is true' do
      expect(helper.toggle_span_class(true)).to include('translate-x-3')
    end

    it 'returns the appropriate class when active is false' do
      expect(helper.toggle_span_class(false)).to include('translate-x-0')
    end
  end
end
