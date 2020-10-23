require "csv"

module BulkAddUsersHelper
  def BulkAddUsersHelper.createFile(uploaded_file, filename)
    File.open(filename, "wb") do |file|
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

  def BulkAddUsersHelper.parseData(filename)
    csv = CSV.read(filename)
    users = []

    valid = true

    upperBound = csv.count - 1
    lowerBound = 1 # loses the title info
    for i in lowerBound..upperBound
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

      if user.invalid?
        valid = false
      end

      users.append(user)
    end

    return users, valid
  end

  def BulkAddUsersHelper.checkNumColumns(filename, numCols = 11)
    csv = CSV.read(filename)

    upperBound = csv.count - 1
    retval = true
    for i in 0..upperBound
      if csv[i].count != numCols
        return false, i, csv[i].count
      end
    end

    return retval, 0, 0
  end

  def BulkAddUsersHelper.saveUsers(users)
    users.each do |user|
      user.save()
      UserKey.create(user_id: user.id, key: SecureRandom.base64(20))
    end
  end
end
