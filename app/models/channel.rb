# frozen_string_literal: true

class Channel < ApplicationRecord
  belongs_to :group

  has_one_attached :artwork
end
