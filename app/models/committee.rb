# frozen_string_literal: true

# Committee Model
class Committee < ApplicationRecord
  self.primary_key = "committee_id"
  validates :committee, :head_first_name, :head_last_name, :email, presence: true

  before_save :point_threshold_validate
  before_update :point_threshold_validate

  def point_threshold_validate
    self.point_threshold = nil if point_threshold.blank?
  end
end
