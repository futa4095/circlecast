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

    it 'グループを削除すること' do
      group = groups(:group1)
      visit group_path(group)
      find('.menu-button').click
      accept_confirm { click_on 'グループの削除' }
      expect(page).not_to have_content group.name
    end
  end

  describe 'メンバーの場合' do
    before do
      sign_in users(:nbc_student1)
    end

    it 'グループを編集が表示されないこと' do
      group = groups(:nbc)
      visit group_path(group)
      find('.menu-button').click
      expect(page).not_to have_content 'グループの編集'
    end

    it 'グループを削除が表示されないこと' do
      group = groups(:nbc)
      visit group_path(group)
      find('.menu-button').click
      expect(page).not_to have_content 'グループの削除'
    end

    it '番組が作るが表示されないこと' do
      group = groups(:nbc)
      visit group_path(group)
      expect(page).not_to have_content '番組を作る'
    end

    it 'グループに招待が表示されないこと' do
      group = groups(:nbc)
      visit group_path(group)
      find('.menu-button').click
      expect(page).not_to have_content 'グループに招待'
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

      it 'メンバーを管理者にできること' do
        click_on 'メンバー'
        expect(page).to have_content 'nbc_student4'
        student_id = ActionView::RecordIdentifier.dom_id(memberships(:nbc_student4))
        find_by_id(student_id).first('button').click
        sleep 1
        admin_form = find_by_id(student_id).first('form')
        expect(admin_form).to have_selector('button[aria-checked="true"]')
      end

      it 'メンバーを脱退させられること'

      it '招待モーダルを表示すること' do
        expect(page).not_to have_content 'リンクを共有してグループに招待'
        find('.menu-button').click
        click_on 'グループに招待'
        expect(page).to have_content 'リンクを共有してグループに招待'
      end
    end
  end
end
