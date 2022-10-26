class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in? #permite que el metodo sea usado por views

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to sign_in_path
        end
    end

end
