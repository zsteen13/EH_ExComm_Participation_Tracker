# frozen_string_literal: true

require_relative '../helpers/activities_helper'
require_relative '../helpers/points_helper'

# ActivitiesController
class ActivitiesController < ApplicationController
  def index
    @activity = Activity.all
  end

  def new
    admin_only
    @prev_data = {}
  end

  def show
    admin_only
    @activity = Activity.find(params[:id])
    @members_attended = UserToActivity.where(activity_id: @activity.id)
  end

  def delete_attendee
    admin_only
    @activity_id = params[:id]
    @attendee = params[:attendee]
    @record = UserToActivity.find_by(uin: @attendee, activity_id: @activity_id)
    @record.destroy
    PointsHelper.update_points(@attendee)
    redirect_to("/activities/#{@activity_id}")
  end

  def delete
    admin_only
    @activity = Activity.find(params[:id])
    UserToActivity.where(activity_id: params[:id]).all.each(&:destroy)
    @activity.destroy
    User.all.each do |user|
      PointsHelper.update_points(user.uin)
    end
    redirect_to('/activities')
  end

  def add_user
    admin_only
    @activity_id = params[:id]
    @uin = params[:uin]
    if !User.where(uin: @uin).take
      flash.alert = "Could not add attendee: Not a valid UIN.\n"
    elsif UserToActivity.where(uin: @uin, activity_id: @activity_id).take
      flash.alert = "Could not add attendee: User already in table.\n"
    else
      UserToActivity.create(uin: @uin, activity_id: @activity_id)
      PointsHelper.update_points(@uin)
    end
    redirect_to("/activities/#{@activity_id}")
  end

  def create
    admin_only

    params.each do |key, _item|
      next unless params[key].blank?

      @error_message = 'One or more input fields were left blank.'
      @prev_data = params
      render('/activities/new')
      return 0
    end

    unless ActivitiesHelper.datetime_correct?(params)
      puts "\n\n"
      puts params
      puts "\n\n"
      @error_message = 'The date or time input was not valid please check your input for date and time'
      @prev_data = params
      render('/activities/new')
      return 0
    end

    params.require(%i[activity_name activity_type date time point_value description])
    act = Activity.new
    act.name = params['activity_name']
    act._type = params['activity_type']
    act.date = ActivitiesHelper.parse_date(params['date'], params['time'])
    act.point_value = params['point_value']
    act.description = params['description']
    act.num_rsvp = 0
    act.save
    redirect_to('/activities')
  end
end
