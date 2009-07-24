class CreateForumThreads < ActiveRecord::Migration
  def self.up
    create_table :forum_threads do |t|
      t.integer :user_id
      t.integer :forum_id
      t.string :title
      t.boolean :locked, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_threads
  end
end
