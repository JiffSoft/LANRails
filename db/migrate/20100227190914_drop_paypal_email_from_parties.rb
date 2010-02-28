class DropPaypalEmailFromParties < ActiveRecord::Migration
  def self.up
    change_table(:parties) do |t|
      t.remove :paypal_address
    end
  end

  def self.down
    change_table(:parties) do |t|
      t.string :paypal_address
    end
  end
end
