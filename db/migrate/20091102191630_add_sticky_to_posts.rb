class AddStickyToPosts < ActiveRecord::Migration
  def self.up
    change_table(:threads) do |t|
      t.column :sticky, :integer, :default => 0
    end
  end

  def self.down
    change_table(:threads) do |t|
      t.remove :sticky
    end
  end
end
