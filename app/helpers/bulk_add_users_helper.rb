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
        committee: csv[i][COMMITTEE_COL_CONST],
        subcommittee: csv[i][SUBCOMMITTE_COL_CONST],
        total_points: csv[i][TOTAL_POINTS_COL_CONST],
        meeting_points: csv[i][MEETING_POINTS_COL_CONST],
        event_points: csv[i][EVENT_POINTS_COL_CONST],
        misc_points: csv[i][MISC_POINTS_COL_CONST],
        admin: (csv[i][ADMIN_COL_CONST]&.downcase == 'true'),
        password_digest: BCrypt::Password.create(Random.new.rand(100.0).to_s)
      )

      valid = false if user.invalid?

      users.append(user)
    end

    [users, valid]
  end

  def self.checkNumColumns(filename, numCols = 4)
    csv = CSV.read(filename)

    upper_bound = csv.count - 1
    retval = true

    (0..upperBound).each do |i|
      return false, i, csv[i].count if csv[i].count < numCols
    end

    [retval, 0, 0]
  end

  def self.save_users(users)
    users.each(&:save)
  end
end
