require 'pp'
class User < ApplicationRecord
  has_many :userkeys
  
  has_secure_password

  # supplied by email_validator gem
  validates :email, email: true
  validates :total_points, :event_points, :meeting_points, :misc_points, numericality: { only_integer: true }
  validates :uin, :first_name, :last_name, presence: true
  validate :valid_uin

  # hardcoded for now
  @@default_point_threshold = 100

  def initialize(args = nil)
    if !args.nil?
      args[:admin] = (args[:admin] == "true" || args[:admin] == true) ? true : false
      args[:total_points] = args[:total_points] != nil ? args[:total_points] : 0
      args[:meeting_points] = args[:meeting_points] != nil ? args[:meeting_points] : 0
      args[:event_points] = args[:event_points] != nil ? args[:event_points] : 0
      args[:misc_points] = args[:misc_points] != nil ? args[:misc_points] : 0
      if Committee.where(committee: args[:committee]).take
        args[:committee] =  Committee.where(committee: args[:committee]).take.committee_id
      else
        args[:committee] = nil
      end
      if Subcommittee.where(subcommittee: args[:subcommittee], committee: args[:committee]).take
        args[:subcommittee] = Subcommittee.where(subcommittee: args[:subcommittee]).take.subcommittee_id
      else
        args[:subcommittee] = nil
      end
      # sets threshold by priority, default > committee > subcommittee
      # this logic does not work yet
      # if !args[:point_threshold]
      #   args[:point_threshold] = @@default_point_threshold
      # end
      # if args[:committee]
      #   args[:point_threshold] = Committee.where(committee_id: args[:committee]).take.point_threshold || @@default_point_threshold
      # end
      # if args[:subcommittee]
      #   args[:point_threshold] = Subcommittee.where(subcommittee_id: args[:subcommittee]).take.point_threshold || @@default_point_threshold
      # end
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
    self[:committee].blank? ? "No assigned committee" : Committee.where(committee_id: self[:committee]).take.committee
  end

  def display_subcommittee
    self[:subcommittee].blank? ? "No assigned subcommittee" : Subcommittee.where(subcommittee_id: self[:subcommittee]).take.subcommittee
  end

  def display_committee_email
    self[:committee].blank? ? "None" : Committee.where(committee_id: self[:committee]).take.email
  end

  def to_s
    return "uin: " + self[:uin].to_s + " first_name: " + self[:first_name] + " last_name " + self[:last_name] + " email: " + self[:email] + " committee: " + self.display_committee + " subcommittee: " + self.display_subcommittee + " total_point: " + self[:total_points].to_s + " meeting_points: " + self[:meeting_points].to_s + " event_points: " + self[:event_points].to_s + " misc_points " + self[:misc_points].to_s + " admin: " + self[:admin].to_s + "\n"
  end
  
  private
  
  def valid_uin # should make this confirm that uin in 9 digits
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
