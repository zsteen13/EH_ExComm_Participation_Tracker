# frozen_string_literal: true

# Committee Model
class Committee < ApplicationRecord
  validates :committee, :head_first_name, :head_last_name, :email, presence: true
  validates :email, email: true
  validates :point_threshold, numericality: { only_integer: true }

  before_save :point_threshold_validate
  before_update :point_threshold_validate
  after_destroy :delete_committee_ties

  def point_threshold_validate
    self.point_threshold = nil if point_threshold.blank?
  end

  # change all members of committe to nul, delete all subcomittees
  def delete_committee_ties
    users = User.all
    users.each do |user|
      next if user.committee.nil?

      user.update(committee: nil) unless Committee.exists?(user.committee)
    end

    subcomittees = Subcommittee.all
    subcomittees.each do |subcommittee|
      subcommittee.destroy unless Committee.exists?(subcommittee.committee)
    end
  end
end
