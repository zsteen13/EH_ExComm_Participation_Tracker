# frozen_string_literal: true

# BulkAddUsersController
class BulkAddUsersController < ApplicationController
  before_action :admin_only

  def index; end

  def create
    uploaded_file = params[:new_users]
    return if uploaded_file.nil?
    filename = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    BulkAddUsersHelper.create_file(uploaded_file, filename)

    redirect_to("/bulk_add_users/show?filename=#{uploaded_file.original_filename}")
  end

  def show
    @file = params[:filename]
    filename = Rails.root.join('public', 'uploads', @file)
    @num_cols = 4
    @correct_num_cols, @row, @col = BulkAddUsersHelper.check_num_columns(filename, @num_cols)
    @users, @valid = BulkAddUsersHelper.parse_data(filename)
  end

  def confirmed
    @file = params[:filename]
    filename = Rails.root.join('public', 'uploads', @file)
    users, _valid = BulkAddUsersHelper.parse_data(filename)
    BulkAddUsersHelper.save_users(users)
    @users = User.all

    redirect_to('/members')
  end

  def correct_csv_all_fields
    filename = Rails.root.join('public', 'data', 'correct_csv_all_fields.csv')
    send_file(filename)
  end

  def correct_csv_required_fields
    filename = Rails.root.join('public', 'data', 'correct_csv_required_fields.csv')
    send_file(filename)
  end

  def correct_csv_some_optional_fields
    filename = Rails.root.join('public', 'data', 'correct_csv_some_optional_fields.csv')
    send_file(filename)
  end

  def incorrect_csv_email_last_name_switched
    filename = Rails.root.join('public', 'data', 'incorrect_csv_email_last_name_switched.csv')
    send_file(filename)
  end

  def incorrect_csv_not_enough_columns
    filename = Rails.root.join('public', 'data', 'incorrect_csv_not_enough_columns.csv')
    send_file(filename)
  end
end
