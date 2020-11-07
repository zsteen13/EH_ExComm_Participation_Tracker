# frozen_string_literal: true

require_relative 'points_helper'

# BulkAddAttendanceHelper
module BulkAddAttendanceHelper
  def self.create_file(uploaded_file, filename)
    File.open(filename, 'wb') do |file|
      file.write(uploaded_file.read)
    end
  end

  def self.parse_data(filename, activity_id)
    csv = CSV.read(filename)
    users = []
    reject = []
    already = []

    upper_bound = csv.count - 1
    lower_bound = 1 # loses the title info
    (lower_bound..upper_bound).each do |i|
      # already in user to activity
      if UserToActivity.where(uin: csv[i][0], activity_id: activity_id).take
        already.append(csv[i][0])
      # valid person and no in user to activity
      elsif User.where(uin: csv[i][0]).take
        user = UserToActivity.new(
          uin: csv[i][0],
          activity_id: activity_id
        )
        users.append(user)
      # not a user in db tables
      else
        reject.append(csv[i][0])
      end
    end

    [users, true, reject, already]
  end

  def self.check_num_columns(filename, num_cols = 1)
    csv = CSV.read(filename)

    upper_bound = csv.count - 1
    retval = true

    (0..upper_bound).each do |i|
      return false, i, csv[i].count if csv[i].count < num_cols
    end

    [retval, 0, 0]
  end

  def self.save_users(users)
    users.each(&:save)
    User.all.each do |user|
      PointsHelper.update_points(user.uin)
    end
  end
end
