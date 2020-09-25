class ApplicationController < ActionController::Base

    before_action :authorized
    helper_method :current_user
    helper_method :logged_in?
    helper_method :is_admin?

    def current_user
        User.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil?
    end

    def authorized
        redirect_to '/welcome' unless logged_in?
    end

    def is_admin?
        redirect_to '/welcome' unless current_user.admin?
    end
end
