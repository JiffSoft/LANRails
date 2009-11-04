class Registration < ActiveRecord::Base
  belongs_to :user
  has_one :party

  validates_presence_of :party_id, :message => "You need a party to register for!"
  validate :party_can_register

protected
  def party_can_regsiter
    errors.add_to_base("This party has happened already!") if party.done?
    errors.add_to_base("This party is currently happening!") if party.running?
  end
end

