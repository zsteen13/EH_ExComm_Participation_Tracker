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

  # hardcoded for now
  @default_point_threshold = 100

  def initialize(args = nil)
    unless args.nil?
      args[:admin] = args[:admin] == 'true' || args[:admin] == true ? true : false
      args[:total_points] = !args[:total_points].nil? ? args[:total_points] : 0
      args[:meeting_points] = !args[:meeting_points].nil? ? args[:meeting_points] : 0
      args[:event_points] = !args[:event_points].nil? ? args[:event_points] : 0
      args[:misc_points] = !args[:misc_points].nil? ? args[:misc_points] : 0
      args[:committee] = (Committee.where(committee: args[:committee]).take.committee_id if Committee.where(committee: args[:committee]).take)
      args[:subcommittee] = (Subcommittee.where(subcommittee: args[:subcommittee]).take.subcommittee_id if Subcommittee.where(subcommittee: args[:subcommittee], committee: args[:committee]).take)
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
    self[:committee].blank? ? 'No assigned committee' : Committee.where(committee_id: self[:committee]).take.committee
  end

  def display_subcommittee
    self[:subcommittee].blank? ? 'No assigned subcommittee' : Subcommittee.where(subcommittee_id: self[:subcommittee]).take.subcommittee
  end

  def display_committee_email
    self[:committee].blank? ? 'None' : Committee.where(committee_id: self[:committee]).take.email
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
    errors.add(:uin, 'must be a length of 9') if uin.length != 9
  end
end
