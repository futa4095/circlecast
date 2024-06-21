# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roots' do
  it 'displays the home page' do
    visit root_path
    expect(page).to have_content 'CIRCLECAST'
    expect(page).to have_none_of_selectors 'body header'
  end

  it 'displays the Terms of Service' do
    visit root_path
    click_on '利用規約'
    expect(page).to have_title '利用規約'
  end

  it 'displays the Privacy Policy' do
    visit root_path
    click_on 'プライバシーポリシー'
    expect(page).to have_title 'プライバシーポリシー'
  end
end
