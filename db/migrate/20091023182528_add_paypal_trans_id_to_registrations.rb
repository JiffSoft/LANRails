class AddPaypalTransIdToRegistrations < ActiveRecord::Migration
  def self.up
    change_table(:registrations) do |t|
      t.column :paypal_transid, :string, :limit => 17, :default => nil
    end
  end

  def self.down
    change_table(:registrations) do |t|
      t.remove :paypal_transid
    end
  end
end
