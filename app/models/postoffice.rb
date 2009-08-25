class Postoffice < ActionMailer::Base
  def verification_email(user)
    recipients user.email
    from Settings[:email_from]
    subject "#{Settings[:site_title]} - New Account Verification"
    body :user => user
  end

  def reset_password(user)
    recipients user.email
    from Settings[:email_from]
    subject "#{Settings[:site_title]} - Password Reset"
    body :user => user
  end
end