# frozen_string_literal: true

require 'csv'

# BulkAddUsersHelper
module BulkAddUsersHelper
  def self.create_file(uploaded_file, filename)
    File.open(filename, 'wb') do |file|
      file.write(uploaded_file.read)
    end
  end

  UIN_COL_CONST = 0
  FIRST_NAME_COL_CONST = 1
  LAST_NAME_COL_CONST = 2
  EMAIL_COL_CONST = 3
  COMMITTEE_COL_CONST = 4
  SUBCOMMITTE_COL_CONST = 5
  TOTAL_POINTS_COL_CONST = 6
  MEETING_POINTS_COL_CONST = 7
  EVENT_POINTS_COL_CONST = 8
  MISC_POINTS_COL_CONST = 9
  ADMIN_COL_CONST = 10

  def self.parse_data(filename)
    csv = CSV.read(filename)
    users = []

    valid = true

    upper_bound = csv.count - 1
    lower_bound = 1 # loses the title info
    (lower_bound..upper_bound).each do |i|
      user = User.new(
        uin: csv[i][UIN_COL_CONST],
        first_name: csv[i][FIRST_NAME_COL_CONST],
        last_name: csv[i][LAST_NAME_COL_CONST],
        email: csv[i][EMAIL_COL_CONST],
        committee: committee_name_to_id(csv[i][COMMITTEE_COL_CONST]),
        subcommittee: subcommittee_name_to_id(csv[i][SUBCOMMITTE_COL_CONST]),
        total_points: csv[i][TOTAL_POINTS_COL_CONST],
        meeting_points: csv[i][MEETING_POINTS_COL_CONST],
        event_points: csv[i][EVENT_POINTS_COL_CONST],
        misc_points: csv[i][MISC_POINTS_COL_CONST],
        admin: (csv[i][ADMIN_COL_CONST]&.downcase == 'true'),
        student: true, # Bulk add users is only for adding students.
        password_digest: BCrypt::Password.create(Random.new.rand(100.0).to_s)
      )

      valid = false if user.invalid?

      users.append(user)
    end

    [users, valid]
  end

  def self.check_num_columns(filename, num_cols = 4)
    csv = CSV.read(filename)

    upper_bound = csv.count - 1
    retval = true

    (0..upper_bound).each do |i|
      return false, i, csv[i].count if csv[i].count < num_cols
    end

    [retval, 0, 0]
  end

  def self.save_users(users)
    users.each do |user|
      UserKey.create(user_id: user.id, key: SecureRandom.base64(20)) if user.save
    end
  end

  def self.committee_name_to_id(committee_name)
    return if committee_name.nil?

    committee = Committee.where('LOWER(committee) = ?', committee_name.downcase).take
    return nil if committee.nil?

    committee.id
  end

  def self.subcommittee_name_to_id(subcommittee_name)
    return if subcommittee_name.nil?

    subcommittee = Subcommittee.where('LOWER(subcommittee) = ?', subcommittee_name.downcase).take
    return nil if subcommittee.nil?

    subcommittee.id
  end
end
