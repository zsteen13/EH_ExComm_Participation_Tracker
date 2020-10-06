class ProfileController < ApplicationController
  def profile
  end

  def attendance
    @attended = UserToActivity.where(uin: current_user.uin)
    @activities = Activity.all
  end
end
