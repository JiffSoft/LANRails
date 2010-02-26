class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :tournament_registrations
  belongs_to :party

  def member_count
    TeamMembership.count_by_sql "SELECT COUNT(*) FROM team_memberships WHERE team_id = #{self.id} AND active = true"
  end

  def leader
    User.find(TeamMembership.find_by_leader_and_team_id(true,self.id))
  end
end
