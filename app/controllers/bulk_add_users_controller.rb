class BulkAddUsersController < ApplicationController
    def index
      @bulk_add_users = BulkAddUser.new
    end
    
    def create
      uploaded_file = params[:new_users]
      filename = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
      BulkAddUsersHelper.createFile(uploaded_file, filename)

      redirect_to('/bulk_add_users')
    end

    def c
  end
  