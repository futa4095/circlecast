# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invitations' do
  fixtures :all
  let(:group) { groups(:nbc) }

  describe 'ログインしている場合' do
    before do
      sign_in users(:no_groups_user)
    end

    it '招待リンクからグループ加入すること' do
      sign_in users(:no_groups_user)
      visit invitations_path(group.invitation.token)

      expect(page).to have_content "#{group.name}に加入しました"
      expect(page).to have_content group.description.tr("\n", ' ')
    end

    describe '既加入の場合' do
      it '重複加入にならないこと' do
        sign_in users(:nakajima)
        visit invitations_path(group.invitation.token)

        expect(page).not_to have_content "#{group.name}に加入しました"
        expect(page).to have_content group.description.tr("\n", ' ')
      end
    end
  end

  describe 'ログインしていない場合' do
    it 'ログイン後にグループに加入すること' do
      visit invitations_path(group.invitation.token)
      expect(page).to have_current_path new_user_session_path, ignore_query: true

      fill_in 'メールアドレス', with: 'nogroups@example.com'
      fill_in 'パスワード', with: 'password'
      click_on 'ログイン'

      expect(page).not_to have_content "#{group.name}に加入しました"
      expect(page).to have_content group.description.tr("\n", ' ')
    end

    it '新規登録後にグループ加入すること' do
      visit invitations_path(group.invitation.token)
      expect(page).to have_current_path new_user_session_path, ignore_query: true

      click_on 'アカウント登録'
      expect(page).to have_content 'ユーザー名'
      expect(page).to have_current_path new_user_registration_path, ignore_query: true
      fill_in 'ユーザー名', with: 'グループ加入希望者'
      fill_in 'メールアドレス', with: 'kanyuu_shitaiyo@example.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      click_on 'アカウント登録'

      expect(page).to have_content '本人確認用のメールを送信しました。'

      user = User.find_by!(email: 'kanyuu_shitaiyo@example.com')
      visit user_confirmation_path(confirmation_token: user.confirmation_token)
      expect(page).to have_content 'メールアドレスが確認できました。'

      fill_in 'メールアドレス', with: 'kanyuu_shitaiyo@example.com'
      fill_in 'パスワード', with: 'password'
      click_on 'ログイン'

      expect(page).to have_content "#{group.name}に加入しました"
      expect(page).to have_content group.description.tr("\n", ' ')
    end
  end
end
