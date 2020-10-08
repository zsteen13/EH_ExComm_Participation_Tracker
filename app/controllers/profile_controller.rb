class ProfileController < ApplicationController
  skip_before_action :authorized, only: [:will_change_password, :change_password, :error]
  
  def profile
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

end
