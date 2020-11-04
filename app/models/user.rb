# frozen_string_literal: true

require 'pp'
# User
class User < ApplicationRecord
  has_many :userkeys

  has_secure_password

  # supplied by email_validator gem
  validates :email, email: true
  validates :total_points, :event_points, :meeting_points, :misc_points, numericality: { only_integer: true }
  validates :uin, :first_name, :last_name, presence: true
  validate :valid_uin

  # First time creation of a user
  after_create do
    UserKey.create(user_id: id, key: SecureRandom.base64(20))
    MemberMailer.with(user: self).signup_email.deliver_later
  end

  def initialize(args = nil)
    unless args.nil?
      args[:admin] = args[:admin] == 'true' || args[:admin] == true ? true : false
      args = handle_args(args)
      # check that committee exists
      args[:committee] = !args[:committee].nil? && Committee.where(id: args[:committee]).take ? args[:committee] : nil
      # checks that subcommittee exists and that it belongs to committee assigned to user
      args[:subcommittee] = !args[:subcommittee].nil? && Subcommittee.where(id: args[:subcommittee], committee: args[:committee]).take ? args[:subcommittee] : nil
      args[:point_threshold] = if args[:committee].nil? && args[:subcommittee].nil?
                                 # set default threshold value
                                 Constant.where(name: 'point_threshold_value').take.value
                               elsif args[:subcommittee].nil?
                                 # update point threshold if member is in a committee
                                 Committee.where(id: args[:committee]).take.point_threshold
                               else
                                 # update point threshold if member is in a subcommittee
                                 Subcommittee.where(id: args[:subcommittee]).take.point_threshold
                               end
    end
    super
  end

  def handle_args(args)
    args[:total_points] = args[:total_points].nil? ? 0 : args[:total_points]
    args[:meeting_points] = args[:meeting_points].nil? ? 0 : args[:meeting_points]
    args[:event_points] = args[:event_points].nil? ? 0 : args[:event_points]
    args[:misc_points] = args[:misc_points].nil? ? 0 : args[:misc_points]
    args[:first_name] = args[:first_name].capitalize()
    args[:last_name] = args[:last_name].capitalize()
    args
  end

  def email=(field)
    field = field.strip if field
    super(field)
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
    self[:committee].blank? ? 'None' : Committee.where(id: self[:committee]).take.committee
  end

  def display_subcommittee
    self[:subcommittee].blank? ? 'None' : Subcommittee.where(id: self[:subcommittee]).take.subcommittee
  end

  def display_committee_email
    self[:committee].blank? ? 'None' : Committee.where(id: self[:committee]).take.email
  end

  def to_s
    "uin: #{self[:uin]} first_name: #{self[:first_name]} last_name #{self[:last_name]} email: #{self[:email]} committee: #{display_committee} subcommittee: #{display_subcommittee} total_point: #{self[:total_points]} meeting_points: #{self[:meeting_points]} event_points: #{self[:event_points]} misc_points #{self[:misc_points]} admin: #{self[:admin]}\n"
  end

  private

  # should make this confirm that uin in 9 digits
  def valid_uin
    if uin.nil?
      return # dont report uin validity if its nil, thats another validators job
    end

    errors.add(:uin, 'must only contain numbers') unless uin.split('').all? { |c| /^[0-9]$/.match?(c) }
    # uncomment in the future, I know this is a messy change but i'm worried its having cascading effects
    errors.add(:uin, 'must be a length of 9') if uin.length != 9
  end
end
