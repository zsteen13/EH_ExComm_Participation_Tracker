# frozen_string_literal: true

# Subcommittee Model
class Subcommittee < ApplicationRecord
  after_destroy :delete_members_subcommittees

  validates :point_threshold, numericality: { only_integer: true }

  def delete_members_subcommittees
    users = User.all
    users.each do |user|
      next if user.subcommittee.nil?

      user.update(subcommittee: nil) unless Subcommittee.exists?(user.subcommittee)
    end
  end
end
