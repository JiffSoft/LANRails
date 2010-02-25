class AddMaxTeamsToTournaments < ActiveRecord::Migration
  def self.up
    change_table(:tournaments) do |t|
      t.column :max_teams, :integer
    end
  end

  def self.down
    change_table(:tournaments) do |t|
      t.remove :max_teams
    end
  end
end
