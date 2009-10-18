class Party < ActiveRecord::Base
  has_many :tournaments
  has_many :news_articles

  validates_format_of :paypal_address, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "is not a valid e-mail address!"
  
  def self.current_party
    Party.find(:last) rescue nil
  end
end
