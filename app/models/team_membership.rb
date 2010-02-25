class TeamMembership < ActiveRecord::Base
  belongs_to :user
  has_one :team
end
