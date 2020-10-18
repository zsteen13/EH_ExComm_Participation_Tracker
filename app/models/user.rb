require 'pp'
class User < ApplicationRecord
  has_many :userkeys
  
  has_secure_password

  # supplied by email_validator gem
  validates :email, email: true
  validates :total_points, :event_points, :meeting_points, :misc_points, numericality: { only_integer: true }
  validates :uin, :first_name, :last_name, presence: true
  validate :valid_uin

  def initialize(args = nil)
    if !args.nil?
      args[:admin] = (args[:admin] == "true" || args[:admin] == true) ? true : false
      args[:committee] = args[:committee] != nil ? args[:committee] : "No assigned committee"
      args[:subcommittee] = args[:subcommittee] != nil ? args[:subcommittee] : "No assigned subcommittee"
      args[:total_points] = args[:total_points] != nil ? args[:total_points] : 0
      args[:meeting_points] = args[:meeting_points] != nil ? args[:meeting_points] : 0
      args[:event_points] = args[:event_points] != nil ? args[:event_points] : 0
      args[:misc_points] = args[:misc_points] != nil ? args[:misc_points] : 0
    end
    super
  end

  def email=(e)
    e = e.strip if e
    super(e)
  end

  def display_total_points
    self[:total_points] || 0
  end

  def display_meeting_points
    self[:meeting_points] || 0
  end

  def display_event_points
    self[:event_points] || 0
  end

  def display_misc_points
    self[:misc_points] || 0
  end

  def display_committee
    self[:committee].blank? ? "No assigned committee" : self[:committee]
  end

  def display_subcommittee
    self[:subcommittee].blank? ? "No assigned subcommittee" : self[:subcommittee]
  end

  def to_s
    return "uin: " + self[:uin].to_s + " first_name: " + self[:first_name] + " last_name " + self[:last_name] + " email: " + self[:email] + " committee: " + self[:committee] + " subcommittee: " + self[:subcommittee] + " total_point: " + self[:total_points].to_s + " meeting_points: " + self[:meeting_points].to_s + " event_points: " + self[:event_points].to_s + " misc_points " + self[:misc_points].to_s + " admin: " + self[:admin].to_s + "\n"
  end
  
  private
  
  def valid_uin
    if uin.nil?
      return # dont report uin validity if its nil, thats another validators job
    end
    if !uin.split('').all? {|c| /^[0-9]$/.match?(c)}
      errors.add(:uin, 'must only contain numbers')
    end
    if uin.length != 9
      errors.add(:uin, "must be a length of 9")
    end
  end

end
