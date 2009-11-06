class AccountsController < ApplicationController
  require "base64"
  require "digest/sha1"
  before_filter :require_login, :only => [:edit, :update]
  uses_tiny_mce :only => [:profile] # for signature
  
  def show
    if (User.current)
      redirect_to edit_account_path
    end
  end

  def login_form
    if User.current && User.current.loggedin?
      redirect_to root_path
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
    redirect_to root_path
  end

  def create
    @user = User.new(params[:user])
    if (Settings[:require_newacct_activation] == 'true')
      @user.status = User::STATUS_INACTIVE # not yet activated
      @user.verifycode = Digest::SHA1.hexdigest(rand(99999999999999).to_s.center(24, rand(9).to_s))
    else
      @user.status = User::STATUS_REGISTERED
    end
    if Settings[:enable_recaptcha].match(/(true|t|yes|y|1)$/i) != nil
      # save with recaptcha
      if (verify_recaptcha(@user) && @user.save)
        if (Settings[:require_newacct_activation] == 'true')
          Postoffice.deliver_verification_email(@user)
        else
          Postoffice.deliver_newuser_email(@user)
        end
        render :action => 'thankyou'
      end
    elsif @user.save
      # we're not using recaptcha
      if (Settings[:require_newacct_activation] == 'true')
        Postoffice.deliver_verification_email(@user)
      else
        Postoffice.deliver_newuser_email(@user)
      end
      render :action => 'thankyou'
    end
  end

  def view
    @user = User.find(params[:user_id])
  end

  def new
    render :action => 'create'
  end

  def activate
    @user = User.find_by_verifycode(params[:activation_code])
    if not @user
      redirect_to root
    end
    @user.status = User::STATUS_REGISTERED
    @user.save
    Postoffice.deliver_newuser_email(@user)
  end

  def thankyou
    redirect_to root
  end

  def recover
    if request.post?
      # populate verifycode, send the recovery email
      @user = User.find_by_username(params[:user_name])
      if not @user
        redirect_to root
      end
      @user.verifycode = Digest::SHA1.hexdigest(rand(99999999999999).to_s.center(24, rand(9).to_s))
      @user.save
      Postoffice.deliver_recovery_email(@user)
    else
      @user = User.find_by_verifycode(params[:activation_code])
      # generate a random password
      @newpass = rand(99999999999999).to_s.center(12, rand(9).to_s)
      @user.password = @newpass
      Postoffice.deliver_new_password_email(@user,@newpass)
    end
  end

  def staff
    @staff = User.find_by_sql "SELECT * FROM #{User.table_name} WHERE status >= #{User::STATUS_MODERATOR}"
  end

  def edit
    @user = User.current
  end

  def update
    if !@user.valid? or !@user.save then
      flash[:error] = "There was an error saving your profile!"
      render :action => 'edit'
    end
  end

private
  def try_login
    User.current = User.try_password_authentication(params[:username], params[:password])
    if User.current.nil?
      # invalid!
      flash[:error] = "Invalid login credentials!"
    elsif User.current.status == User::STATUS_INACTIVE
      # we're not active yet!
      flash[:warning] = "Your e-mail has not yet been confirmed!"
      User.current = nil
    else
      session[:user_id] = User.current.id
      if not params[:id]
        redirect_to root_path
      else
        redirect_to Base64.decode64(params[:id])
      end
    end
  end
end
