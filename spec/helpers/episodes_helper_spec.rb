# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EpisodesHelper do
  describe '公開日を編集する' do
    it '公開後の更新がない場合、公開日のみであること'
    it '公開後の更新がある場合、更新日を含むこと'
  end
end
