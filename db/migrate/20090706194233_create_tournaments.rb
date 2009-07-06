class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.integer :game_id
      t.integer :party_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :tournaments
  end
end
