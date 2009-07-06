class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.text :signature
      t.boolean :admin, :default => 'false'

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
