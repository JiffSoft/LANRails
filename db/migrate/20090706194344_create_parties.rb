class CreateParties < ActiveRecord::Migration
  def self.up
    create_table :parties do |t|
      t.string  :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :address
      t.string :city
      t.string :stateprov
      t.string :zip
      t.float :price
      t.integer :maximum_registrations

      t.timestamps
    end
  end

  def self.down
    drop_table :parties
  end
end
