# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roots' do
  it 'トップページを表示すること' do
    visit root_path
    expect(page).to have_content 'CIRCLECAST'
    expect(page).to have_none_of_selectors 'body header'
  end

  it '利用規約を表示すること' do
    visit root_path
    click_on '利用規約'
    expect(page).to have_title '利用規約'
  end

  it 'プライバシーポリシーを表示すること' do
    visit root_path
    click_on 'プライバシーポリシー'
    expect(page).to have_title 'プライバシーポリシー'
  end
end
