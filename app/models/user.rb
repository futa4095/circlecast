# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :memberships, dependent: :destroy
  has_many :groups, -> { where(memberships: { withdrawal: false }) }, through: :memberships
  has_many :channels, -> { where(memberships: { withdrawal: false }) }, through: :groups

  validates :name, presence: true
end
