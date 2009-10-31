module SavageBeast::AuthenticationSystem
    def update_last_seen_at
      #return unless logged_in?
      #User.update_all ['last_seen_at = ?', Time.now.utc], ['id = ?', current_user.id] 
      #current_user.last_seen_at = Time.now.utc
    end

    def login_required
    require_login
  end

  def authorized?()
    require_administrator
    true
  end

  def current_user
    User.current
  end

  def logged_in?
    User.current && User.current.loggedin?
  end

  def admin?
    User.current && User.current.admin?
  end
end