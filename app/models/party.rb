class Party < ActiveRecord::Base
  has_many :tournaments
  has_many :registrations
  has_many :prizes
  
  def self.current_party
    Party.find(:last) rescue nil
  end

  def registered_count
    Registration.count_by_sql "SELECT COUNT(*) FROM registrations WHERE party_id = #{self.id}"
  end

  def running?
    self.start_time < Time.now and self.end_time > Time.now
  end

  def past?
    self.end_time < Time.now
  end
end
