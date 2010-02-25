class Tournament < ActiveRecord::Base
  belongs_to :party
  has_many :tournament_registrations
end
