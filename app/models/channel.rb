# frozen_string_literal: true

class Channel < ApplicationRecord
  belongs_to :group
  has_many :episodes
  has_one_attached :artwork

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :artwork, content_type: ['image/jpeg', 'image/png', 'image/webp'],
                      dimension: { width: { in: 300..3000 }, height: { in: 300..3000 } },
                      size: { between: (1.kilobyte)..(3.megabyte) }
end
