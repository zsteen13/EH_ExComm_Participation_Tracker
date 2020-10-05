require 'csv'

module BulkAddUsersHelper
    def BulkAddUsersHelper.createFile(uploaded_file, filename)
        File.open(filename, 'wb') do |file|
            file.write(uploaded_file.read)
          end
    end

    def BulkAddUsersHelper.parseData(filename)
        UIN_COL = 0
        FIRST_NAME_COL = 1
        LAST_NAME_COL = 2
        EMAIL_COL = 3
        COMMITTEE_COL = 4
        SUBCOMMITTE_COL = 5
        TOTAL_POINTS_COL = 6
        MEETING_POINTS_COL = 7 
        EVENT_POINTS_COL = 8 
        MISC_POINTS_COL = 9 
        ADMIN_COL = 10
        
        csv = CSV.read(filename)        
        users = []

        valid = true

        upperBound = csv.count - 1
        lowerBound = 1 # loses the title info
        for i in lowerBound..upperBound
            user = User.new(
                uin:csv[i][UIN_COL],
                first_name:csv[i][FIRST_NAME_COL],
                last_name:csv[i][LAST_NAME_COL],
                email:csv[i][EMAIL_COL],
                committee:csv[i][COMMITTEE_COL],
                subcommittee:csv[i][subcommittee_col],
                total_points:csv[i][TOTAL_POINTS_COL],
                meeting_points:csv[i][MEETING_POINTS_COL],
                event_points:csv[i][EVENT_POINTS_COL],
                misc_points:csv[i][MISC_POINTS_COL],
                admin:csv[i][ADMIN_COL]
            )

            users.append(user)

            if user.invalid?
                valid = false
            end
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
        end
    end
end