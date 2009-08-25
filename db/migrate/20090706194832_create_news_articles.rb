class CreateNewsArticles < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.integer :user_id
      t.integer :party_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
