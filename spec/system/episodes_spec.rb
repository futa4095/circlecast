# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Episodes', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe '管理者の場合' do
    it 'エピソードを作成すること'
    it 'エピソードを削除すること'
  end

  describe 'メンバーの場合' do
    it 'エピソードを表示すること'
    it 'エピソードを聴けること'
  end
end
