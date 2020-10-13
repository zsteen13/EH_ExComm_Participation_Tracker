# frozen_string_literal: true

# BulkAddUsersController
class BulkAddUsersController < ApplicationController
  before_action :admin_only

  def index; end

  def create
    uploaded_file = params[:new_users]
    filename = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    BulkAddUsersHelper.create_file(uploaded_file, filename)

    redirect_to("/bulk_add_users/show?filename=#{uploaded_file.original_filename}")
  end

  def show
    @file = params[:filename]

    filename = Rails.root.join('public', 'uploads', @file)
    @num_cols = 11
    @correct_num_cols, @row, @col = BulkAddUsersHelper.check_num_cols(filename, @num_cols)
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
end
