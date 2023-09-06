# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups' do
  fixtures :all

  describe '管理者の場合' do
    before do
      sign_in users(:nakajima)
    end

    it 'グループを作成すること' do
      visit groups_path
      click_on 'グループを作る'
      fill_in '名前', with: '新しいグループ'
      fill_in '説明', with: 'グループの説明です'
      click_on '登録する'
      expect(page).to have_content 'グループを作成しました'
      expect(page).to have_content '新しいグループ'
    end

    it 'グループを削除すること', pending: 'バグ解消待ち' do
      group = groups(:group1)
      visit groups_path(group)
      click_on 'グループを削除'
    end
  end

  describe 'グループに所属していない場合' do
    it '作成を促すメッセージを表示すること' do
      sign_in users(:no_groups_user)
      visit groups_path
      expect(page).to have_content 'グループに参加していません！'
    end
  end

  describe '詳細ページ' do
    before do
      sign_in users(:nakajima)
      visit group_path(groups(:nbc))
    end

    it '新着エピソードを表示すること' do
      expect(page).to have_content '第9回のエピソード'
    end

    it '番組一覧を表示すること' do
      click_on '番組'
      expect(page).to have_content '中島ブートキャンプへようこそ'
    end

    describe 'グループ管理者の場合' do
      it 'メンバー一覧を表示すること' do
        click_on 'メンバー'
        expect(page).to have_content 'nbc_student1'
      end

      it 'メンバーを管理者にできること', pending: '書き方がわかわないので後回し' do
        click_on 'メンバー'
        within ".#{dom_id memberships(:nbc_student4)}" do
          first('button').click
        end
        within ".#{dom_id memberships(:nbc_student4)}" do
          first('button').click
          expect(page).to have_content 'nbc_student1'
        end
      end

      it 'メンバーを脱退させられること'
      it '招待モーダルを表示すること' do
        expect(page).not_to have_content 'リンクを共有してグループに招待'
        click_on 'グループに招待'
        expect(page).to have_content 'リンクを共有してグループに招待'
      end
    end
  end
end
