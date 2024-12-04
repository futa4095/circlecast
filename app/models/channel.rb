# frozen_string_literal: true

class Channel < ApplicationRecord
  belongs_to :group
  has_many :episodes, dependent: :destroy
  has_one_attached :artwork

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :artwork, content_type: ['image/jpeg', 'image/png', 'image/webp'],
                      dimension: { width: { in: 300..3000 }, height: { in: 300..3000 } },
                      size: { between: (1.kilobyte)..(3.megabytes) }

  def artwork_url
    if artwork.attached?
      artwork
    else
      'default-channel.svg'
    end
  end

  def artwork_alt
    if artwork.attached?
      "#{title}のアートワーク"
    else
      '番組のアートワーク'
    end
  end
end
