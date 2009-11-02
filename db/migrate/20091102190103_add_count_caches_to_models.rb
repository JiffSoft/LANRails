class AddCountCachesToModels < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.column :posts_count, :integer, :default => 0
    end
    change_table(:threads) do |t|
      t.column :posts_count, :integer, :default => 0
    end
    change_table(:forums) do |t|
      t.column :posts_count, :integer, :default => 0
      t.column :threads_count, :integer, :default => 0
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove :posts_count
    end
    change_table(:threads) do |t|
      t.remove :posts_count
    end
    change_table(:forums) do |t|
      t.remove :threads_count
      t.remove :posts_count
    end
  end
end
