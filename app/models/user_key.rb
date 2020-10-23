# frozen_string_literal: true

class UserKey < ApplicationRecord
  validates :key, :user_id, presence: true
end
