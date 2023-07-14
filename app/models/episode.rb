# frozen_string_literal: true

class Episode < ApplicationRecord
  belongs_to :channel
  has_one_attached :enclosure

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :enclosure, attached: true,
                        content_type: ['audio/mpeg', 'audio/mp4'],
                        size: { between: (1.kilobyte)..(100.megabyte) }
end
