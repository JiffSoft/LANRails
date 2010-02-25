class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :tournament_registrations
  belongs_to :party
end
