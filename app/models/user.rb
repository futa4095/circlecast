# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable

  has_many :memberships, dependent: :destroy
  has_many :channels, through: :groups
  has_many :episodes, through: :channels

  validates :name, presence: true

  def groups
    Group.joins(:memberships).where(memberships: { user: self, withdrawal: false })
  end
end
