class AddBioToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.column :bio, :text
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove :bio
    end
  end
end
