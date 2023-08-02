# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :group

  validates :token, presence: true,
                    uniqueness: true
end
