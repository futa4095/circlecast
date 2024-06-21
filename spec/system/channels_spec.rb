# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Channels' do
  fixtures :all

  context 'when the user is an admin' do
    before do
      sign_in users(:nakajima)
    end

    it 'creates a new channel' do
      visit group_path(groups(:group1))
      click_on '番組を作る'
      fill_in 'タイトル', with: 'テスト番組のタイトル'
      fill_in '説明', with: 'テスト番組の説明文です。毎日お昼頃に投稿しています。その日のちょっとしたニュースをお届けします。'
      click_on '登録する'

      expect(page).to have_content '番組を作成しました'
      expect(page).to have_content 'テスト番組のタイトル'
      expect(page).to have_content 'テスト番組の説明文です。'
    end

    it 'deletes the channel' do
      visit channel_path(channels(:group2_ch1))
      find('.menu-button').click
      accept_confirm { click_on '削除' }

      expect(page).to have_content '番組を削除しました'
      expect(page).not_to have_content 'ばんぐみ1'
    end
  end

  context 'when the user is a member' do
    before do
      sign_in users(:nbc_student1)
      visit channel_path(channels(:nbc_channel1))
    end

    it 'displays the list of episodes' do
      expect(page).to have_content '第49回のエピソード'
      expect(page).to have_content '第30回のエピソード'
    end

    it 'does not show the menu button' do
      expect(page).not_to have_selector '.menu-button'
    end

    it 'does not show the option to create a new episode' do
      expect(page).not_to have_content 'エピソードを作成'
    end
  end

  context 'when there are no episodes' do
    it 'shows a message encouraging to create a new post' do
      sign_in users(:nakajima)
      visit channel_path(channels(:group2_ch1))
      expect(page).to have_content 'ポッドキャストをみんなに届けよう'
    end

    it 'shows a message that the channel is under preparation' do
      sign_in users(:nbc_student1)
      visit channel_path(channels(:nbc_channel4))
      expect(page).to have_content 'この番組は準備中です'
    end
  end
end
