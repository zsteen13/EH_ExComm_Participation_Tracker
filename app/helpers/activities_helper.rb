# frozen_string_literal: true

require 'date'

# ActivitiesHelper
module ActivitiesHelper
  def self.parse_date(date, time)
    date_split = date.split('-', 3)
    year = date_split[0].to_i
    month = date_split[1].to_i
    day = date_split[2].to_i

    time_split = time.split(':', 2)
    hour = time_split[0].to_i
    minute = time_split[1].to_i

    DateTime.new(year, month, day, hour, minute, 0, Rational(-5, 24))
  end

  def self.correct_num_field?(map)
    keys = %w[activity_name activity_type date time point_value description]
    has_all_keys = true

    keys.each do |key|
      has_key = map.key?(key)
      has_all_keys &= has_key
    end
    has_all_keys
  end

  def self.number?(string)
    true if Float(string)
  rescue StandardError
    false
  end

  def self.datetime_correct?(map)
    date = map['date']
    time = map['time']

    return false if date.length != 10

    return false if time.length != 5

    date_split = date.split('-', 3)
    year = date_split[0]
    month = date_split[1]
    day = date_split[2]

    time_split = time.split(':', 2)
    hour = time_split[0]
    minute = time_split[1]

    return false unless number?(year)

    return false unless number?(month)

    return false unless number?(day)

    return false unless number?(hour)

    return false unless number?(minute)

    hour = hour.to_i
    minute = minute.to_i
    month = month.to_i
    day = day.to_i
    year = year.to_i

    return false if (hour >= 24) || hour.negative?

    return false if (minute > 59) || minute.negative?

    return false if (month > 12) || (month < 1)

    return false if (day > 31) || (day < 1)

    return false if (year < 1000) || (year > 9999)

    true
  end
end
