class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    # unused, will be removed in later branch
    # @user = User.create(params.require(:user).permit(:first_name, :last_name))
    # session[:user_id] = @user.id
    # redirect_to '/welcome'
  end
end
