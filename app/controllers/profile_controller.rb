# frozen_string_literal: true

require 'pp'
# ProfileController
class ProfileController < ApplicationController
  skip_before_action :authorized, only: %i[will_change_password change_password error]

  def profile
    ## Generates the User's Points Based on the UserToActivites Point Count
    @attended = UserToActivity.where(uin: current_user.uin)
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

    current_user.update(total_points: sum_total_points.to_i)
    current_user.update(meeting_points: sum_meeting_points.to_i)
    current_user.update(event_points: sum_event_points.to_i)
    current_user.update(misc_points: sum_misc_points.to_i)
  end

  def will_change_password
    if logged_in?
      @user = current_user
    else
      key = request.query_parameters['key']
      redirect_to profile_error_path and return if key.nil?

      # Does this key exist in any row?
      user_key = UserKey.where(key: key).find { |user_k| user_k.key == key } # could also be ...where().first.user_key
      redirect_to profile_error_path and return if user_key.nil?

      @user = User.find(user_key.user_id)
    end
  end

  def change_password
    @user = User.find(params[:user][:id])
    unless params[:user][:first_password].present? && params[:user][:second_password].present?
      flash.now[:notice] = 'Please fill out both passwords'
      render :will_change_password and return
    end
    if params[:user][:first_password] != params[:user][:second_password]
      flash.now[:notice] = 'Passwords are not the same'
      render :will_change_password and return
    end

    begin
      @user.update!(password: params[:user][:first_password])
    rescue ActiveRecord::RecordInvalid
      render :error and return
    end
    unless logged_in? then UserKey.where(user_id: @user.id).delete_all end # different than destroy_all
    redirect_to welcome_path
  end

  def error; end

  def attendance
    @attended = UserToActivity.where(uin: current_user.uin)
    @activities = Activity.all
  end
end
