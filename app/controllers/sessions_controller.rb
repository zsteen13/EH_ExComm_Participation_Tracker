class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    # any get request to /login is a a logout
    session[:user_id] = nil
    redirect_to '/welcome'
  end

  def create
    redirect_to welcome_path and return if !params[:uin].present?
    redirect_to welcome_path and return if !params[:password].present?
    @user = User.find_by(uin: params[:uin])
    redirect_to welcome_path and return if @user.nil?
    if BCrypt::Password.new(@user.password_digest) == params[:password]
      session[:user_id] = @user.id
    end
    redirect_to '/welcome'
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end
end
