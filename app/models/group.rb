# frozen_string_literal: true

class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }

  has_many :memberships
  has_many :users, through: :memberships
end
