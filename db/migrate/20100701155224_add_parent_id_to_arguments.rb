class AddParentIdToArguments < ActiveRecord::Migration
  def self.up
    add_column :arguments, :parent_id, :integer
  end

  def self.down
    remove_column :arguments, :parent_id
  end
end
