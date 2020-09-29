require 'csv'

module BulkAddUsersHelper
    def BulkAddUsersHelper.createFile(uploaded_file, filename)
        File.open(filename, 'wb') do |file|
            file.write(uploaded_file.read)
          end
    end

    def BulkAddUsersHelper.parseData(filename)
        
        csv = CSV.read(filename)
        upperBound = csv.count - 1
        lowerBound = 1 # loses the title info
        for i in lowerBound..upperBound

        end

    end

    def BulkAddUsersHelper.checkNumColumns(csv)
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