class Episode < ApplicationRecord
  belongs_to :channel
  has_one_attached :enclosure

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
end
