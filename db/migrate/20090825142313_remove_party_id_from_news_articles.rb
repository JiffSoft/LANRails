class RemovePartyIdFromNewsArticles < ActiveRecord::Migration
  def self.up
    change_table(:news) do |t|
      t.remove :party_id
    end
  end

  def self.down
    change_table(:news) do |t|
      t.column :party_id, :integer
    end
  end
end
