class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.integer :party_id
      t.text :description
      t.boolean :moderated, :default => 'true'
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
