# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invitations', type: :system do
  describe 'ログインしている場合' do
    it '招待リンクからグループ加入すること'
    describe '既加入の場合' do
      it '重複加入にならないこと'
    end
  end
  describe 'ログインしていない場合' do
    it 'ログイン後にグループに加入すること'
    it '新規登録後にグループ加入すること'
  end
end
