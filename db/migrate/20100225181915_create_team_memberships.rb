class CreateTeamMemberships < ActiveRecord::Migration
  def self.up
    create_table :team_memberships do |t|
      t.integer :team_id
      t.integer :user_id
      t.boolean :leader, :default => false
      t.boolean :active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :team_memberships
  end
end
