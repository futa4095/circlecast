# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  it 'ログイン・ログアウトできること' do
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'nakajima@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_content '参加しているグループ'

    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
    expect(current_path).to eq root_path
  end
end
