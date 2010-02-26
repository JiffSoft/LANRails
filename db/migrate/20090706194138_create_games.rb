class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :name
      t.text :description
      t.string :url
    end
  end

  def self.down
    drop_table :games
  end
end
