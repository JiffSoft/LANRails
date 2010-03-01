class AddInviteCodeToTeamMemberships < ActiveRecord::Migration
  def self.up
    change_table(:team_memberships) do |t|
      t.string :invite_code, :default => nil
    end
  end

  def self.down
    change_table(:team_memberships) do |t|
      t.remove :invite_code
    end
  end
end
