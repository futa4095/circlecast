# frozen_string_literal: true

class Channel < ApplicationRecord
  belongs_to :group
end
