class UpdateGamesTable < ActiveRecord::Migration
  def self.up
    change_table(:games) do |t|
      t.remove :description
      t.remove :url
      t.string :short_name
      t.string :game_type
    end
  end

  def self.down
    change_table(:games) do |t|
      t.remove :short_name
      t.remove :game_type
      t.text :description
      t.string :url
    end
  end
end
