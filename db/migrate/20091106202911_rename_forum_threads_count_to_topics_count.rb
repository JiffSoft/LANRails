class RenameForumThreadsCountToTopicsCount < ActiveRecord::Migration
  def self.up
    rename_column :forums, :threads_count, :topics_count
  end

  def self.down
    rename_column :forums, :topics_count, :threads_count
  end
end
