class TournamentRegistration < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :team
end
