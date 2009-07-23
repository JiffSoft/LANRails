class User < ActiveRecord::Base
  require 'digest/sha1'

  has_many :games
  has_many :registrations
  has_many :news_articles

  validates_presence_of :username, :message => "A username is required!"
  validates_uniqueness_of :username, :message => "That username is already registered!"
  validates_presence_of :password, :message => "A password is required!"
  validates_length_of :password, :minimum => 6, :message => "Your password must be at least 6 characters long!"
  validates_uniqueness_of :email, :message => "An account already exists with that e-mail!"

  STATUS_INACTIVE = 0
  STATUS_REGISTERED = 1
  STATUS_MODERATOR = 7
  STATUS_ADMIN = 15

  def self.try_cookie_authentication(key)
    # TODO make me
  end

  def active?
    self.status != STATUS_INACTIVE
  end

  def password=(str)
    write_attribute("password",Digest::SHA1.hexdigest(str))
  end

  def self.current
    #TODO anonymous stuff
    @me ||= nil
  end

  def self.current=(user)
    @me = user
  end

  def loggedin?
    false unless @me
  end

  def anonymous?
    !loggedin?
  end
end
