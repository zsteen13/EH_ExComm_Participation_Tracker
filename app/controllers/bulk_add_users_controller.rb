# frozen_string_literal: true

class BulkAddUsersController < ApplicationController
  before_action :admin_only

  def index; end

  def create
    uploaded_file = params[:new_users]
    filename = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    BulkAddUsersHelper.createFile(uploaded_file, filename)

    redirect_to("/bulk_add_users/show?filename=#{uploaded_file.original_filename}")
  end

  def show
    @file = params[:filename]

    filename = Rails.root.join('public', 'uploads', @file)
    @numCols = 11
    @correct_num_cols, @row, @col = BulkAddUsersHelper.checkNumColumns(filename, @numCols)
    @users, @valid = BulkAddUsersHelper.parseData(filename)
  end

  def confirmed
    @file = params[:filename]
    filename = Rails.root.join('public', 'uploads', @file)
    users, valid = BulkAddUsersHelper.parseData(filename)
    BulkAddUsersHelper.saveUsers(users)
    @users = User.all

    redirect_to('/members')
  end
end
