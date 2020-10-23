# frozen_string_literal: true

require_relative '../helpers/activities_helper'

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
    @activity = Activity.find(params[:id])
    @members_attended = UserToActivity.where(activity_id: @activity.id)
  end

  def create
    admin_only
    unless ActivitiesHelper.correct_num_field?(params)
      @error_message = 'There were too many parameter or not enough parameters sumbitted'
      @prev_data = params
      render('/activities/new')
      return
    end

    unless ActivitiesHelper.datetime_correct?(params)
      puts "\n\n"
      puts params
      puts "\n\n"
      @error_message = 'The date or time input was not valid please check your input for date and time'
      @prev_data = params
      render('/activities/new')
      return
    end

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
