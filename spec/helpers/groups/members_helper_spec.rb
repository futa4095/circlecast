# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Groups::MembersHelper do
  describe '#toggle_button' do
    let(:user) { User.create(email: 'test@example.com', password: 'password', name: 'test user') }
    let(:group) { Group.create(name: 'test group') }
    let(:current_user) { User.create(email: 'current@example.com', password: 'password', name: 'current user') }
    let(:membership) { group.memberships.create(user:, admin: true) }

    context 'when current_user is the same as membership.user' do
      it 'returns nil' do
        expect(helper.toggle_button(user, membership, :admin)).to be_nil
      end
    end

    context 'when current_user is different from membership.user' do
      it 'returns a button tag' do
        result = helper.toggle_button(current_user, membership, :admin)
        expect(result).to match(/<form[^>]+method="post"/)
        expect(result).to match(/aria-checked="true"/)
        expect(result).to match(/class=".*bg-blue-700.*"/)
        expect(result).to match(/<span/)
      end
    end
  end

  describe '#toggle_button_class' do
    context 'when active is true' do
      it 'returns the appropriate class' do
        expect(helper.toggle_button_class(true)).to include('bg-blue-700')
      end
    end

    context 'when active is false' do
      it 'returns the appropriate class' do
        expect(helper.toggle_button_class(false)).to include('bg-gray-200')
      end
    end
  end

  describe '#toggle_span_class' do
    context 'when active is true' do
      it 'returns the appropriate class' do
        expect(helper.toggle_span_class(true)).to include('translate-x-3')
      end
    end

    context 'when active is false' do
      it 'returns the appropriate class' do
        expect(helper.toggle_span_class(false)).to include('translate-x-0')
      end
    end
  end
end
