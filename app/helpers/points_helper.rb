# frozen_string_literal: true

# PointsHelper
module PointsHelper
  def self.update_points(uin)
    @attended = UserToActivity.where(uin: uin)
    sum_total_points = 0
    sum_meeting_points = 0
    sum_event_points = 0
    sum_misc_points = 0

    @member = User.where(uin: uin)

    @attended.each do |attended|
      value = Activity.find(attended.activity_id).point_value.to_i
      sum_total_points += value

      case Activity.find(attended.activity_id)._type
      when 'Meeting'
        sum_meeting_points += value
      when 'Event'
        sum_event_points += value
      when 'Misc'
        sum_misc_points += value
      end
    end

    @member.update_all(
      total_points: sum_total_points,
      meeting_points: sum_meeting_points,
      event_points: sum_event_points,
      misc_points: sum_misc_points
    )
  end
end
