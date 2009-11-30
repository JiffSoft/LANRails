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

  def party_registration_email(user, party, registration)
    recipients user.email
    from Settings[:email_from]
    subject "#{party.name} Registration Confirmation"
    body :user => user, :party => party, :reg => registration
  end

  def party_prepay_complete_email(user, party, registration)
    recipients user.email
    from Settings[:email_from]
    subject "#{party.name} Pre-Pay Confirmation"
    body :user => user, :party => party, :reg => registration
  end

  def party_prepay_warning_email(user, party, registration)
    recipients user.email
    from Settings[:email_from]
    subject "#{party.name} Pre-Pay Confirmation"
    body :user => user, :party => party, :reg => registration
  end

  def new_post_email(uid, topic, post)
    user = User.find(uid)
    recipients user.email
    from Settings[:email_from]
    subject "#{Settings[:site_title]} - #{topic.title} New Post"
    body :user => user, :topic => topic, :post => post
  end
end