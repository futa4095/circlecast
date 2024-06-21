# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups' do
  fixtures :all

  context 'when the user is an admin' do
    before do
      sign_in users(:nakajima)
    end

    it 'creates a new group' do
      visit groups_path
      click_on 'グループを作る'
      fill_in '名前', with: '新しいグループ'
      fill_in '説明', with: 'グループの説明です'
      click_on '登録する'
      expect(page).to have_content 'グループを作成しました'
      expect(page).to have_content '新しいグループ'
    end

    it 'deletes the group' do
      group = groups(:group1)
      visit group_path(group)
      find('.menu-button').click
      accept_confirm { click_on 'グループの削除' }
      expect(page).not_to have_content group.name
    end
  end

  context 'when the user is a member' do
    before do
      sign_in users(:nbc_student1)
    end

    around do |example|
      original = Capybara.raise_server_errors
      Capybara.raise_server_errors = false
      example.run
      Capybara.raise_server_errors = original
    end

    it 'does not show the option to edit the group' do
      group = groups(:nbc)
      visit group_path(group)
      find('.menu-button').click
      expect(page).not_to have_content 'グループの編集'
    end

    it 'does not show the option to delete the group' do
      group = groups(:nbc)
      visit group_path(group)
      find('.menu-button').click
      expect(page).not_to have_content 'グループの削除'
    end

    it 'does not show the option to create a new channel' do
      group = groups(:nbc)
      visit group_path(group)
      expect(page).not_to have_content '番組を作る'
    end

    it 'does not show the option to invite to the group' do
      group = groups(:nbc)
      visit group_path(group)
      find('.menu-button').click
      expect(page).not_to have_content 'グループに招待'
    end

    it 'withdraws from the group' do
      group = groups(:nbc)
      visit group_path(group)
      find('.menu-button').click
      accept_confirm { click_on 'グループから脱退' }
      expect(page).to have_content "#{group.name}から脱退しました"
      visit group_path(group)
      expect(page).to have_text 'ActiveRecord::RecordNotFound'
    end
  end

  context 'when the user has no group' do
    it 'shows a message encouraging to join or create a group' do
      sign_in users(:no_groups_user)
      visit groups_path
      expect(page).to have_content 'まずは、グループに所属しよう！'
    end
  end

  describe '詳細ページ' do
    before do
      sign_in users(:nakajima)
      visit group_path(groups(:nbc))
    end

    it 'displays recent episodes' do
      expect(page).to have_content '第49回のエピソード'
    end

    it 'displays the list of channels' do
      click_on '番組'
      expect(page).to have_content '中島ブートキャンプへようこそ'
    end

    context 'when the user is an admin' do
      it 'displays the list of members' do
        click_on 'メンバー'
        expect(page).to have_content 'nbc_student1'
      end

      it 'allows promoting a member to admin' do
        click_on 'メンバー'
        expect(page).to have_content 'nbc_student4'
        student_id = ActionView::RecordIdentifier.dom_id(memberships(:nbc_student4))
        find_by_id(student_id).first('button').click
        sleep 0.5
        admin_form = find_by_id(student_id).first('form')
        expect(admin_form).to have_selector('button[aria-checked="true"]')
      end

      it 'allows removing a member from the group' do
        click_on 'メンバー'
        expect(page).to have_content 'nbc_student4'
        student_id = ActionView::RecordIdentifier.dom_id(memberships(:nbc_student4))
        find_by_id(student_id).all('button').last.click
        sleep 0.5
        admin_form = find_by_id(student_id).all('form').last
        expect(admin_form).to have_selector('button[aria-checked="true"]')
      end

      it 'displays the invite modal' do
        expect(page).not_to have_content 'リンクを共有してグループに招待'
        find('.menu-button').click
        click_on 'グループに招待'
        expect(page).to have_content 'リンクを共有してグループに招待'
      end
    end
  end
end
