# frozen_string_literal: true

class Channel < ApplicationRecord
  belongs_to :group

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }

  has_one_attached :artwork
end
