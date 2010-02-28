class AddTeamSizeToTournaments < ActiveRecord::Migration
  def self.up
    change_table(:tournaments) do |t|
      t.integer :team_size
    end
  end

  def self.down
    change_table(:tournaments) do |t|
      t.remove :team_size
    end
  end
end
