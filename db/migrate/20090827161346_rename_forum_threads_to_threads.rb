class RenameForumThreadsToThreads < ActiveRecord::Migration
  def self.up
    rename_table :forum_threads, :threads
  end

  def self.down
    rename_table :threads, :forum_threads
  end
end
