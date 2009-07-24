# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery :secret => 'ASDHFAD7F098723H192364TGASDA612'

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :start

  def start
    Settings.check_cache
    User.current = check_current_session
  end

  def check_current_session
    if (session[:user_id])
      User.active.find(session[:user_id]) rescue nil
    elsif (cookies[:autologin])
      User.try_cookie_authentication(cookies[:autologin]) rescue nil
    end
  end
  
  def require_login
    redirect_to :controller => 'account', :action => 'login' unless User.current && User.current.active?
  end
  
  def require_moderator
    redirect_to :controller => 'account', :action => 'login' unless User.current && User.current.moderator?
  end
  
  def require_administrator
    redirect_to :controller => 'account', :action => 'login' unless User.current && User.current.admin?
  end
end
