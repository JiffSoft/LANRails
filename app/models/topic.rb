class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum, :counter_cache => true
  has_many :posts

  validates_length_of :title, :maximum => 64
  validates_length_of :title, :minimum => 4
  validates_presence_of :user_id
  validates_presence_of :forum_id

  MAXIMUM_POSTS_PER_PAGE = 25

  def can_reply?
    locked == false
  end

  def paged?
    pages > Topic::MAXIMUM_POSTS_PER_PAGE
  end

  def pages
    Post.count(:id, :conditions => {:thread_id => id})
  end

  def update_cached_fields(post)
    self.class.update_all(['updated_at = ?, posts_count = ?',post.created_at, posts.count],['id = ? ', id])
  end
end
