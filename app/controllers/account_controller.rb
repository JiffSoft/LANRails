class AccountController < ApplicationController
  uses_tiny_mce :only => [:profile] # for signature
  
  def index
    if (User.current)
      redirect_to :controller => 'account', :action => 'profile'
    else
      redirect_to :controller => 'account', :action => 'login'
    end
  end

  def login
  end

  def logout
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

end
