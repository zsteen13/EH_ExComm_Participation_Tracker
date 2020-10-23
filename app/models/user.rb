require 'pp'
class User < ApplicationRecord
  has_many :userkeys

  has_secure_password

  # supplied by email_validator gem
  validates :email, email: true
  validates :total_points, :event_points, :meeting_points, :misc_points, numericality: { only_integer: true }
  validates :uin, :first_name, :last_name, :committee, :subcommittee, presence: true
  validate :valid_uin

  # First time creation of a user
  after_create do
    UserKey.create(user_id: id, key: SecureRandom.base64(20))
    MemberMailer.with(user: self).signup_email.deliver_later
  end

  def initialize(args = nil)
    unless args.nil?
      args[:admin] = args[:admin] == 'true' || args[:admin] == true ? true : false
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
    self[:committee].blank? ? 'No assigned committee' : self[:committee]
  end

  def display_subcommittee
    self[:subcommittee].blank? ? 'No assigned subcommittee' : self[:subcommittee]
  end

  def to_s
    'uin: ' + self[:uin].to_s + ' first_name: ' + self[:first_name] + ' last_name ' + self[:last_name] + ' email: ' + self[:email] + ' committee: ' + self[:committee] + ' subcommittee: ' + self[:subcommittee] + ' total_point: ' + self[:total_points].to_s + ' meeting_points: ' + self[:meeting_points].to_s + ' event_points: ' + self[:event_points].to_s + ' misc_points ' + self[:misc_points].to_s + ' admin: ' + self[:admin].to_s + "\n"
  end

  private

  def valid_uin
    if uin.nil?
      nil # dont report uin validity if its nil, thats another validators job
    elsif !uin.split('').all? { |c| /^[0-9]$/.match?(c) }
      errors.add(:uin, 'UIN must only contain numbers')
    end
  end
end
