class ApplicationController < ActionController::Base

    protect_from_forgery unless: -> { request.format.json? }

    before_action :authorized
    helper_method :current_user
    helper_method :logged_in?
    helper_method :is_admin?
    helper_method :admin_only

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
        current_user.admin?
    end

    def admin_only
        redirect_to '/welcome' unless is_admin?
    end
end
