require "date"

module ActivitiesHelper
    def ActivitiesHelper.parse_date(date, time)
        date_split = date.split("-", 3)
        year = date_split[0].to_i()
        month = date_split[1].to_i()
        day = date_split[2].to_i()

        time_split = time.split(":", 2)
        hour = time_split[0].to_i()
        minute = time_split[1].to_i()

        return DateTime.new(year, month, day, hour, minute, 0, Rational(-5, 24))        
    end

    def ActivitiesHelper.correct_num_field?(map)
    keys = ["activity_name", "activity_type", "date", "time", "point_value", "description"]
    has_all_keys = true

    for key in keys
        has_key = map.has_key?(key)
        has_all_keys = has_all_keys & has_key
    end
    return has_all_keys
    end

    def ActivitiesHelper.is_number?(string)
        true if Float(string) rescue false
    end

    def ActivitiesHelper.datetime_correct?(map)
        date = map["date"]
        time = map["time"]

        if date.length != 10
            return false
        end

        if time.length != 5
            return false
        end

        date_split = date.split("-", 3)
        year = date_split[0]
        month = date_split[1]
        day = date_split[2]

        time_split = time.split(":", 2)
        hour = time_split[0]
        minute = time_split[1]

        if !is_number?(year) 
            return false
        end

        if !is_number?(month) 
            return false
        end

        if !is_number?(day) 
            return false
        end

        if !is_number?(hour) 
            return false
        end

        if !is_number?(minute) 
            return false
        end

        hour = hour.to_i
        minute = minute.to_i
        month = month.to_i
        day = day.to_i
        year = year.to_i

        if (hour >= 24) || (hour < 0)
            return false
        end

        if (minute > 59) || (minute < 0)
            return false
        end

        if (month > 12) || (month < 1)
            return false
        end

        if (day > 31) || (day < 1)
            return false
        end

        if (year < 1000) || (year > 9999)
            return false
        end

        return true
    end
end