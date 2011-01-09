class AddVotesCountToArguments < ActiveRecord::Migration
  def self.up
    add_column :arguments, :votes_count, :integer, :default => 0
    Argument.reset_column_information
    Argument.find(:all).each do |a| 
      Argument.update_counters a.id, :votes_count => a.votes.count
    end
  end

  def self.down
    remove_column :arguments, :votes_count
  end
end
