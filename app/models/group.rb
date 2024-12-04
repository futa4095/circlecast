# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :channels, dependent: :destroy
  has_many :episodes, through: :channels
  has_one :invitation, dependent: :destroy
  has_one_attached :icon

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :icon, content_type: ['image/jpeg', 'image/png', 'image/webp'],
                   dimension: { width: { in: 300..3000 }, height: { in: 300..3000 } },
                   size: { between: (1.kilobyte)..(3.megabytes) }

  def add_member(user)
    users << user
  end

  def withdraw_member(user)
    membership = memberships.find_by(user:)
    membership.update!(withdrawal: true)
  end

  def admin?(user)
    membership = memberships.find_by(user:)
    membership&.admin
  end

  def only_one_admin?
    memberships.where(admin: true, withdrawal: false).count == 1
  end

  def recent_episodes
    Episode.eager_load(:channel).where(channel: { group: self }).order(created_at: :desc)
  end

  def icon_url
    if icon.attached?
      icon
    else
      'default-group.svg'
    end
  end

  def icon_alt
    if icon.attached?
      "#{name}のアイコン"
    else
      'グループのアイコン'
    end
  end
end
