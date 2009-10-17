class Party < ActiveRecord::Base
  has_many :tournaments
  has_many :news_articles
  
  def self.current_party
    Party.find(:last) rescue nil
  end
end
