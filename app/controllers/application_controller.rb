# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  require "base64"
  require 'gravatar'
  helper :all # include all helpers, all the time
  protect_from_forgery

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :start

  def start
    Settings.check_cache
    ActionMailer::Base.default_url_options[:host] = request.host
    if Settings[:enable_recaptcha].match(/(true|t|yes|y|1)$/i) != nil then
      ENV['RECAPTCHA_PUBLIC_KEY'] = Settings[:recaptcha_public]
      ENV['RECAPTCHA_PRIVATE_KEY'] = Settings[:recaptcha_private]
    end
    User.current = check_current_session
  end

  def check_current_session
    # Try cookie login, automagic login, etc.
    if (session[:user_id])
      User.current = User.find_by_id(session[:user_id])
    elsif (cookies[:autologin])
      User.try_cookie_authentication(cookies[:autologin]) rescue nil
    end
  end
  
  def require_login
    redirect_to login_path(:id => Base64.encode64(request.request_uri))  unless User.current && User.current.active?
  end
  
  def require_moderator
    redirect_to login_path(:id => Base64.encode64(request.request_uri)) unless User.current && User.current.moderator?
  end
  
  def require_administrator
    redirect_to login_path(:id => Base64.encode64(request.request_uri)) unless User.current && User.current.admin?
  end
end
