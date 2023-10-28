# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :memberships, dependent: :destroy

  validates :name, presence: true

  def groups
    Group.joins(:memberships).where(memberships: { user: self, withdrawal: false })
  end

  def channels
    Channel.joins(group: :memberships).where(memberships: { user: self, withdrawal: false })
  end
end
