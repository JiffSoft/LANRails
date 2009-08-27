class AccountsController < ApplicationController
  require "base64"
  uses_tiny_mce :only => [:profile] # for signature
  
  def show
    if (User.current)
      redirect_to edit_account_path
    end
  end

  def login
    if User.current && User.current.loggedin?
      redirect_to edit_account_path
    else
      try_login
    end
  end

  def logout
    session[:user_id] = nil
    reset_session
    redirect_to :controller => 'news'
  end

  def create
    @user = User.new(params[:user])
    if (Settings[:require_newacct_activation] == 'true')
      @user.status = User::STATUS_INACTIVE # not yet activated
    else
      @user.status = User::STATUS_REGISTERED
    end
    if ENV['RECAPTCHA_PUBLIC_KEY']
      # save with recaptcha
      if (verify_recaptcha(@user) && @user.save)
        if (Settings[:require_newacct_activation] == 'true')
          Postoffice.deliver_verification_email(@user)
        end
        render :partial => 'thankyou'
      end
    elsif @user.save
      # we're not using recaptcha
      if (Settings[:require_newacct_activation] == 'true')
        Postoffice.deliver_verification_email(@user)
      end
      render :partial => 'thankyou'
    end
    render :action => 'new'
  end

  def view
    @user = User.find(params[:user_id])
  end

  def activate
    @user = User.find_all_by_verifycode(params[:activation_code])
    if not @user
      redirect_to root
    end
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
