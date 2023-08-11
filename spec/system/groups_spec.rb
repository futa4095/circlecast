# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  before do
    driven_by(:rack_test)
  end
  fixtures :users
  let(:user) { users(:nakajima) }

  it '作ること' do
    sign_in user
    visit groups_path
    expect(page).to have_content '参加しているグループ'
  end

  describe 'グループ管理者の場合' do
    it '削除すること'
  end

  describe 'グループに所属していない場合' do
    it '作成を促すメッセージを表示すること'
  end

  describe '詳細ページ' do
    it '新着エピソードを表示すること'
    it '番組一覧を表示すること'
    describe 'グループ管理者の場合' do
      it '番組を作成できること'
      it 'メンバー一覧を表示すること'
      it 'メンバーを管理者にできること'
      it 'メンバーを脱退させられること'
      it '招待モーダルを表示すること'
    end
  end
end
