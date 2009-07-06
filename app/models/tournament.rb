class Tournament < ActiveRecord::Base
  has_one :game
  has_many :users
  belongs_to :party
end
