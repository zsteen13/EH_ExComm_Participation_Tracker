# frozen_string_literal: true

# UserKey
class UserKey < ApplicationRecord
  validates :key, :user_id, presence: true
end
