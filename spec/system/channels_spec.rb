# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Channels', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe '管理者の場合' do
    it '番組を作成すること'
    it '番組を削除すること'
  end

  describe 'メンバーの場合' do
    it 'エピソードを一覧表示すること'
  end

  describe 'エピソードが投稿されていない場合' do
    it '未投稿メッセージを表示すること'
  end
end
