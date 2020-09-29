class User < ApplicationRecord
  # supplied by email_validator gem
  validates :email, email: true

  def email=(e)
    e = e.strip if e
    super(e)
  end

  def display_total_points
    self[:total_points] || "0"
  end

  def display_meeting_points
    self[:meeting_points] || "0"
  end

  def display_event_points
    self[:event_points] || "0"
  end

  def display_committee
    self[:committee].blank? ? "No assigned committee" : self[:committee]
  end

  def display_subcommittee
    self[:subcommittee].blank? ? "No assigned committee" : self[:subcommittee]
  end
end
