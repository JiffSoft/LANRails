class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.integer :user_id
      t.integer :party_id
      t.boolean :paid, :default => 'false'
      
      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
