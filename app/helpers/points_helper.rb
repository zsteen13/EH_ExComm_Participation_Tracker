# frozen_string_literal: true

# PointsHelper
module PointsHelper
  def self.update_points(uin)
    @attended = UserToActivity.where(uin: uin)
    sum_total_points = 0
    sum_meeting_points = 0
    sum_event_points = 0
    sum_misc_points = 0

    @attended.each do |attended|
      sum_total_points += Activity.find(attended.activity_id).point_value

      case Activity.find(attended.activity_id)._type
      when 'Meeting'
        sum_meeting_points += Activity.find(attended.activity_id).point_value
      when 'Event'
        sum_event_points += Activity.find(attended.activity_id).point_value
      when 'Misc'
        sum_misc_points += Activity.find(attended.activity_id).point_value
      end
    end
  end
end
