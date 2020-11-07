# frozen_string_literal: true

# BulkAddAttendanceController
class BulkAddAttendanceController < ApplicationController
  before_action :admin_only

  def index
    admin_only
    @activity = Activity.find(params[:id])
    @members_attended = UserToActivity.where(activity_id: @activity.id)
  end

  def help
    admin_only
    @activity = Activity.find(params[:id])
  end

  def correct_csv
    filename = Rails.root.join('public', 'data', 'correct_attendance.csv')
    send_file(filename)
  end

  def create
    uploaded_file = params[:new_users]
    filename = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    BulkAddAttendanceHelper.create_file(uploaded_file, filename)
    redirect_to("/activities/#{params[:id]}/bulk_add/show?filename=#{uploaded_file.original_filename}")
  end

  def show
    @activity_id = params[:id]
    @file = params[:filename]
    filename = Rails.root.join('public', 'uploads', @file)
    @num_cols = 1
    @correct_num_cols, @row, @col = BulkAddAttendanceHelper.check_num_columns(filename, @num_cols)
    @attendees, @valid, @reject, @already = BulkAddAttendanceHelper.parse_data(filename, @activity_id)
  end

  def confirmed
    @file = params[:filename]
    @activity_id = params[:id]
    filename = Rails.root.join('public', 'uploads', @file)
    users, _valid, _reject, _already = BulkAddAttendanceHelper.parse_data(filename, @activity_id)
    BulkAddAttendanceHelper.save_users(users)
    @users = User.all
    redirect_to("/activities/#{@activity_id}")
  end
end
