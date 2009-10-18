class AddPaypalAddressToParties < ActiveRecord::Migration
  def self.up
    change_table(:parties) do |t|
      t.column :paypal_address, :text
    end
  end

  def self.down
    change_table(:parties) do |t|
      t.remove :paypal_address
    end
  end
end
