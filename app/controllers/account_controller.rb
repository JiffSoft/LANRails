class AccountController < ApplicationController
  require "base64"
  uses_tiny_mce :only => [:profile] # for signature
  
  def index
    if (User.current)
      redirect_to :controller => 'account', :action => 'profile'
    else
      redirect_to :controller => 'account', :action => 'login'
    end
  end

  def login
    if User.current && User.current.loggedin?
      redirect_to "/"
    end
    if request.post?
      try_login
    end
  end

  def logout
    session[:user_id] = nil
    reset_session
    redirect_to :controller => 'news'
  end

  def create
    if request.post?
      @user = User.new(params[:user])
      if (Settings[:require_newacct_activation] == 'true')
        @user.status = 0 # not yet activated
      end
      if ENV['RECAPTCHA_PUBLIC_KEY']
        # save with recaptcha
        if (verify_recaptcha(@user) && @user.save)
          render :partial => 'thankyou'
        end
      elsif @user.save
        # we're not using recaptcha
        render :partial => 'thankyou'        
      end
    end
    # TODO send activation email
  end

  def rescue
  end

  def profile
  end

  def activate
  end

private
  def try_login
    User.current = User.try_password_authentication(params[:username], params[:password])
    if User.current.nil?
      # invalid!
      @login_error = "Invalid login!"
    elsif User.current.status == User::STATUS_INACTIVE
      # we're not active yet!
      @login_error = "Your e-mail has not yet been confirmed!"
    else
      session[:user_id] = User.current.id
      if not params[:id]
        redirect_to :controller => 'news'
      else
        redirect_to Base64.decode64(params[:id])
      end
    end
  end

end
