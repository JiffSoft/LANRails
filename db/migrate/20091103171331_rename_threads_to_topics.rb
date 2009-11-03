class RenameThreadsToTopics < ActiveRecord::Migration
  def self.up
    rename_table :threads, :topics
    rename_column :posts, :thread_id, :topic_id
  end

  def self.down
    rename_table :topics, :threads
    rename_column :posts, :topic_id, :thread_id
  end
end
