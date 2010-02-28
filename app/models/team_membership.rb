class TeamMembership < ActiveRecord::Base
  belongs_to :user
  has_one :team

  validates_uniqueness_of :leader, :scope => [:team_id], :message => "teams may only have one leader!"
end
