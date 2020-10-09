class ProfileController < ApplicationController
  skip_before_action :authorized, only: [:will_change_password, :change_password, :error]
  
  def profile

    ## Generates the User's Points Based on the UserToActivites Point Count
    @attended = UserToActivity.where(uin: current_user.uin)
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

    current_user.update(total_points: sumTotalPoints.to_i)
    current_user.update(meeting_points: sumMeetingPoints.to_i)
    current_user.update(event_points: sumEventPoints.to_i)
    current_user.update(misc_points: sumMiscPoints.to_i)
  end

  def will_change_password
    if logged_in?
      @user = current_user
    else
      key = request.query_parameters['key']
      redirect_to profile_error_path and return if key.nil?

      # Does this key exist in any row?
      user_key = UserKey.where(:key => key).find {|user_key| user_key.key == key}
      redirect_to profile_error_path and return if user_key.nil?

      @user = User.find(user_key.user_id)
    end
  end

  def change_password
    pp params
=begin
    if !(params[:first_password].present? && params[:second_password].present?)
      flash.now[:notice] = 'Please fill out both passwords'
      render :will_change_password
    end
    if params[:first_password] != params[:second_password]
      flash.now[:notice] = 'Passwords are not the same'
      render :will_change_password
    end
    if logged_in?
      
    else
      begin
        @user.update!(password: params[:first_password])
      rescue ActiveRecord::RecordInvalid
        pp @user
        render :error
      end
    end
=end
  end

  def error
  end

  def attendance
    @attended = UserToActivity.where(uin: current_user.uin)
    @activities = Activity.all
  end

  def attendance
    @attended = UserToActivity.where(uin: current_user.uin)
    @activities = Activity.all
  end
  
end
