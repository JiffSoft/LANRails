class AddVerifycodeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :verifycode, :text
    
    # Migrate active/registered users status to 3 to accomidate
    # new status 1 for password recovery
  end

  def self.down
    remove_column :users, :verifycode
  end
end
