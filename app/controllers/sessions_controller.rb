class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    @user = User.find_by(uin: params[:uin])
    if @user && @user.last_name == params[:last_name]
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      redirect_to '/welcome'
    end
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end
end
