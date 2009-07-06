class Party < ActiveRecord::Base
  has_many :tournaments
  has_many :news_articles
end
