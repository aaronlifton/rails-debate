class CreateSides < ActiveRecord::Migration
  def self.up
    create_table :sides do |t|
      t.string :name
      t.text :description
      t.integer :debate_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sides
  end
end
