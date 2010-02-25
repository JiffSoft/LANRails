class CreateTournamentRegistrations < ActiveRecord::Migration
  def self.up
    create_table :tournament_registrations do |t|
      t.integer :team_id
      t.integer :tournament_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tournament_registrations
  end
end
