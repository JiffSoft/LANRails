class RenameForumPostsToPosts < ActiveRecord::Migration
  def self.up
    rename_table :forum_posts, :posts
  end

  def self.down
    rename_table :posts, :forum_posts
  end
end
