class Tournament < ActiveRecord::Base
  belongs_to :party
  has_many :tournament_registrations
  has_many :teams, :through => :tournament_registrations
  belongs_to :game # wierd...want to use has_one, because it makes more sense...

  validates_presence_of :name, :message => 'is required!'
  validates_length_of :name, :within => 3..34, :message => 'must be between 3 and 34 characters!'
  validates_presence_of :team_size, :message => 'a maximum team size is required!'
  validates_numericality_of :team_size, :greater_than => 0, :less_than_or_equal_to => 20, :message => 'team sizes must be between 0 and 20'

  def current_registrations
    self.teams.count
  end

  def is_registered?(user)
    TournamentRegistration.count_by_sql "SELECT COUNT(r.*) FROM tournament_registrations r
        INNER JOIN team_memberships m ON m.tournament_id = r.tournament_id AND r.user_id = #{user.id}
        WHERE r.tournament_id = #{self.id}" != 0      
  end

  def users_team(user)
    Team.find_all_by_party_id(self.id, :joins => [:teams, "INNER JOIN team_memberships ON team_memberships.user_id = #{user} AND team_memberships.team_id = team.id"]) rescue nil
  end
end
