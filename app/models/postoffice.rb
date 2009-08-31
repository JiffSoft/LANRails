class Postoffice < ActionMailer::Base
  def verification_email(user)
    recipients user.email
    from Settings[:email_from]
    subject "#{Settings[:site_title]} - New Account Verification"
    body :user => user
  end

  def newuser_email(user)
    recipients user.email
    from Settings[:email_from]
    subject "#{Settings[:site_title]} - Welcome!"
    body :user => user
  end

  def recovery_email(user)
    recipients user.email
    from Settings[:email_from]
    subject "#{Settings[:site_title]} - Account Recovery"
    body :user => user
  end

  def new_password_email(user, newpass)
    recipients user.email
    from Settings[:email_from]
    subject "#{Settings[:site_title]} - Your New Password"
    body :user => user, :password => newpass
  end
end