class Forum < ActiveRecord::Base
  has_many :forum_threads
end
