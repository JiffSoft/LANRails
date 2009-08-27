class Forum < ActiveRecord::Base
  has_many :threads
  has_many :posts, :through => :threads
end
