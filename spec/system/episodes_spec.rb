# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Episodes' do
  fixtures :all

  context 'when the user is an admin' do
    before do
      sign_in users(:nakajima)
    end

    it 'creates a new episode' do
      visit channel_path(channels(:group2_ch1))
      click_on 'エピソードを作成'
      fill_in 'タイトル', with: '新しいエピソードのタイトル！'
      fill_in '説明', with: '新しいエピソードの説明です。新しいエピソードの説明その2です。'
      attach_file '音声ファイル', 'spec/fixtures/files/audio1.m4a'
      click_on '登録する'

      expect(page).to have_content 'エピソードを作成しました'
      expect(page).to have_content '新しいエピソードのタイトル！'
      expect(page).to have_content '新しいエピソードの説明です。'
    end

    it 'deletes the episode' do
      visit channel_episode_path(channels(:nbc_channel2), episodes(:nbc_episode21))
      find('.menu-button').click
      accept_confirm { click_on '削除' }

      expect(page).to have_content 'エピソードを削除しました'
      expect(page).not_to have_content 'ep.1 2月2日'
    end
  end

  context 'when the user is a member' do
    before do
      sign_in users(:nbc_student1)
      visit channel_path(channels(:nbc_channel2))
    end

    it 'displays the episode' do
      click_on 'ep.1 2月2日'

      expect(page).to have_content 'ep.1 2月2日'
      expect(page).to have_content '必聴です'
      audio = all('audio')
      expect(audio.size).to eq 1
    end

    it 'does not show the menu button' do
      expect(page).not_to have_selector '.menu-button'
    end
  end
end
