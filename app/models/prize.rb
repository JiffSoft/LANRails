class Prize < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :party
  belongs_to :tournament
end
