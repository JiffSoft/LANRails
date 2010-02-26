class Tournament < ActiveRecord::Base
  belongs_to :party
  has_many :tournament_registrations

  validates_presence_of :name, :message => 'is required!'
  validates_length_of :name, :within => 3..34, :message => 'must be between 3 and 34 characters!'

  def current_registrations
    TournamentRegistration.count_by_sql "SELECT COUNT(*) FROM tournament_registrations WHERE tournament_id = #{self.id}"
  end

  def is_registered?(user)
    TournamentRegistration.count_by_sql "SELECT COUNT(r.*) FROM tournament_registrations r
        INNER JOIN team_memberships m ON m.tournament_id = r.tournament_id AND r.user_id = #{user.id}
        WHERE r.tournament_id = #{self.id}" != 0      
  end
end
