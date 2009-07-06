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

  def self.authenticate(username,password)
    find(:first,:conditions => ["username = ? and password = ?",username,
        Digest::SHA1.hexdigest(password)])
  end

  def password=(str)
    write_attribute("password",Digest::SHA1.hexdigest(str))
  end
end
