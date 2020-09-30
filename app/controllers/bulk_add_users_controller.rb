class BulkAddUsersController < ApplicationController

  def index
  end
  
  def create
    uploaded_file = params[:new_users]
    filename = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    BulkAddUsersHelper.createFile(uploaded_file, filename)

    redirect_to("/bulk_add_users/show?filename=#{uploaded_file.original_filename}")
  end

  def show
    filename = Rails.root.join('public', 'uploads', params[:filename])
    puts "\n\n#{filename}\n\n"
    @users, @valid = BulkAddUsersHelper.parseData(filename)
  end

  end
  