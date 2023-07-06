# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :group
  belongs_to :user
end
