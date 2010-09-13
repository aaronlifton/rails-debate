class CreateArguments < ActiveRecord::Migration
  def self.up
    create_table :arguments do |t|
      t.text :body
      t.integer :side_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :arguments
  end
end
