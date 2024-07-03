# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  it 'can log in and log out' do
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'nakajima@example.com'
    fill_in 'パスワード', with: 'passpass'
    click_on 'ログイン'
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_content '参加しているグループ'

    find('header nav svg').click
    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
    expect(page).to have_current_path root_path, ignore_query: true
  end

  it 'does not show the header on the registration page' do
    visit new_user_registration_path
    expect(page).to have_none_of_selectors 'body header'
  end
end
