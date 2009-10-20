class Thread < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  has_many :posts

  validates_length_of :title, :maximum => 64, :minimum => 4

  MAXIMUM_POSTS_PER_PAGE = 25

  def can_reply?
    locked == false
  end

  def paged?
    pages > Thread::MAXIMUM_POSTS_PER_PAGE
  end

  def pages
    Post.count(:id, :conditions => {:thread_id => id})
  end
end
