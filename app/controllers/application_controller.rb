class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  protected
    def forbidden
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end

    def require_admin
      unless administrateur?
        forbidden
      end
    end

    def require_login
      unless logged_in?
        redirect_to log_in_url
      end
    end

    def require_no_login
      if logged_in?
        redirect_to root_url
      end
    end

end
