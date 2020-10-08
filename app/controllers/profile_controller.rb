class ProfileController < ApplicationController
  def profile

    ## Generates the User's Points Based on the UserToActivites Point Count
    @attended = UserToActivity.where(uin: current_user.uin)
    user = User.find_by(uin: current_user.uin)
    sumTotalPoints = 0
    sumMeetingPoints = 0
    sumEventPoints = 0;
    sumMiscPoints = 0

    @attended.each do |attended|
      sumTotalPoints += Activity.find(attended.activity_id).point_value

      if Activity.find(attended.activity_id)._type == 'Meeting'
        sumMeetingPoints += Activity.find(attended.activity_id).point_value
      elsif Activity.find(attended.activity_id)._type == 'Event'
        sumEventPoints += Activity.find(attended.activity_id).point_value
      elsif Activity.find(attended.activity_id)._type == 'Misc'
        sumMiscPoints += Activity.find(attended.activity_id).point_value
      end      
    end

    user.update(total_points: sumTotalPoints)
    user.update(meeting_points: sumMeetingPoints)
    user.update(event_points: sumEventPoints)
    user.update(misc_points: sumMiscPoints)

  end

  def attendance
    @attended = UserToActivity.where(uin: current_user.uin)
    @activities = Activity.all
  end
end
