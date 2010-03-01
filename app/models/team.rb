class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :tournament_registrations
  has_many :users, :through => :team_memberships
  belongs_to :party

  validates_uniqueness_of :name, :scope => :party_id, :message => "team names must be unique!"
  validates_presence_of :name, :message => "a team name is required!"

  def member_count
    TeamMembership.count_by_sql "SELECT COUNT(*) FROM team_memberships WHERE team_id = #{self.id}"
  end

  def leader
    User.find(TeamMembership.find_by_leader_and_team_id(true,self.id).user_id)
  end

  def is_registered?(tournament)
    true if TournamentRegistration.find_by_tournament_id_and_team_id(tournament,self.id)
  end

  def self.user_has_team?(party,user)
    true if TeamMembership.find_all_by_user_id(user, :joins => "INNER JOIN teams ON teams.id = team_memberships.team_id AND teams.party_id = #{party}")
    false
  end
end
