# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Channels' do
  fixtures :all

  describe '管理者の場合' do
    before do
      sign_in users(:nakajima)
    end

    it '番組を作成すること' do
      visit group_path(groups(:group1))
      click_on '番組を作る'
      fill_in 'タイトル', with: 'テスト番組のタイトル'
      fill_in '説明', with: 'テスト番組の説明文です。毎日お昼頃に投稿しています。その日のちょっとしたニュースをお届けします。'
      click_on '登録する'

      expect(page).to have_content '番組を作成しました'
      expect(page).to have_content 'テスト番組のタイトル'
      expect(page).to have_content 'テスト番組の説明文です。'
    end

    it '番組を削除すること' do
      visit channel_path(channels(:group2_ch1))
      find('.menu-button').click
      accept_confirm { click_on '削除' }

      expect(page).to have_content '番組を削除しました'
      expect(page).not_to have_content 'ばんぐみ1'
    end
  end

  describe 'メンバーの場合' do
    before do
      sign_in users(:nbc_student1)
      visit channel_path(channels(:nbc_channel1))
    end

    it 'エピソードを一覧表示すること' do
      expect(page).to have_content '第49回のエピソード'
      expect(page).to have_content '第30回のエピソード'
    end

    it 'メニューボタンを表示しないこと' do
      expect(page).not_to have_selector '.menu-button'
    end

    it 'エピソードの作成を表示しないこと' do
      expect(page).not_to have_content 'エピソードを作成'
    end
  end

  describe 'エピソードが投稿されていない場合' do
    it '投稿を促すメッセージを表示すること' do
      sign_in users(:nakajima)
      visit channel_path(channels(:group2_ch1))
      expect(page).to have_content 'ポッドキャストをみんなに届けよう'
    end

    it '準備中メッセージを表示すること' do
      sign_in users(:nbc_student1)
      visit channel_path(channels(:nbc_channel4))
      expect(page).to have_content 'この番組は準備中です'
    end
  end
end
