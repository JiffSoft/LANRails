class User < ActiveRecord::Base
  require 'digest/sha1'

  has_many :registrations
  has_many :news
  has_many :topics
  has_many :posts

  attr_readonly :posts_count

  validates_presence_of :username, :message => "is required!"
  validates_uniqueness_of :username, :message => "is already registered!"
  validates_presence_of :password, :message => "is required!"
  validates_length_of :password, :minimum => 6, :message => "must be at least 6 characters long!"
  validates_length_of :username, :minimum => 6, :message => "must be at least 6 characters long!"
  validates_uniqueness_of :email, :message => "has already been registered!"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "is not a valid e-mail address!"
  validates_format_of :username, :with => /^[a-z0-9_\-@\.]*$/i, :message => "may only contain numbers, letters, and underscores!"
  validates_confirmation_of :password, :message => "and password confirmation do not match!"

  STATUS_ANONYMOUS = -1
  STATUS_INACTIVE = 0
  STATUS_RECOVERY = 1
  STATUS_REGISTERED = 3
  STATUS_MODERATOR = 7
  STATUS_ADMIN = 15

  def self.try_password_authentication(user, pass)
    return nil if user.to_s.empty? || pass.to_s.empty?
    u = find(:first, :conditions => ["UPPER(username) = ?", user.to_s.upcase])
    return nil unless u
    return nil unless u.password == User::password_hash(pass)
    @me = u
    return u
  rescue => err
    raise err
  end

  def self.try_cookie_authentication(key)
    # TODO make me
  end

  def active?
    self.status > STATUS_INACTIVE rescue false
  end
  
  def moderator?
    self.status >= STATUS_MODERATOR rescue false
  end
  
  def admin?
    self.status >= STATUS_ADMIN rescue false
  end

  def password=(str)
    write_attribute("password",Digest::SHA1.hexdigest(str))
  end
  def password_confirmation=(str)
    write_attribute("password_confirmation",Digest::SHA1.hexdigest(str))
  end
  
  def self.password_hash(str)
    return Digest::SHA1.hexdigest(str)
  end

  def self.current
    #TODO anonymous stuff
    @me ||= nil
  end

  def self.current=(user)
    @me = user
  end

  def loggedin?
    false unless @me else true rescue false
  end

  def anonymous?
    !loggedin?
  end

  def registered?(party)
    Registration.find_by_party_id_and_user_id(party,self.id) != nil rescue false
  end

  def get_registration(party)
    return Registration.find_by_party_id_and_user_id(party,self.id) rescue nil
  end

  def has_team?(party)
    true if self.own_team(party)
  end

  def has_team_leader?(party)
    TeamMembership.find_by_team_id(self.own_team(party).id).leader rescue false
  end

  def own_team(party)
    Team.find_by_party_id(party, :joins => "INNER JOIN team_memberships ON team_memberships.team_id
        AND team_memberships.user_id =#{self.id}")
  end

  def complete_verification(code)
    if code == self.verifycode
      self.status = STATUS_REGISTERED
      self.verifycode = nil
      return true
    else
      return false
    end 
  end
end
