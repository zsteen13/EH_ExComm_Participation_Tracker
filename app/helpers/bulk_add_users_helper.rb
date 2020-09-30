require 'csv'

module BulkAddUsersHelper
    def BulkAddUsersHelper.createFile(uploaded_file, filename)
        File.open(filename, 'wb') do |file|
            file.write(uploaded_file.read)
          end
    end

    def BulkAddUsersHelper.parseData(filename)
        uin_col = 0
        first_name_col = 1
        last_name_col = 2
        email_col = 3
        committee_col = 4
        subcommittee_col = 5
        total_point_col = 6
        meeting_point_col = 7 
        event_point_col = 8 
        misc_point_col = 9 
        admin_col = 10
        
        csv = CSV.read(filename)        
        users = []

        upperBound = csv.count - 1
        lowerBound = 1 # loses the title info
        for i in lowerBound..upperBound
            user = User.new(
                uin:csv[i][uin_col],
                first_name:csv[i][first_name_col],
                last_name:csv[i][last_name_col],
                email:csv[i][email_col],
                committee:csv[i][committee_col],
                subcommittee:csv[i][subcommittee_col],
                total_points:csv[i][total_point_col],
                meeting_points:csv[i][meeting_point_col],
                event_points:csv[i][event_point_col],
                misc_points:csv[i][misc_point_col],
                admin:csv[i][admin_col]
            )

            users.append(user)

            if user.invalid?
                return users, false
            end
        end

        return users, true

    end

    def BulkAddUsersHelper.checkNumColumns(filename)
        csv = CSV.read(filename)        

        numCols = 11
        upperBound = csv.count - 1
        retval = true
        for i in 0..upperBound
            value = csv[i].count == numCols
            retval = value & retval
        end

        return retval
    end
end