class Registration < ActiveRecord::Base
  belongs_to :user
  has_one :party
end
