class AddManVoteWomanVote < ActiveRecord::Migration
  def up
    add_column :nude_reports, :man_vote_count, :integer, :default => 0   
    add_column :nude_reports, :woman_vote_count, :integer, :default => 0
  end

  def down
    remove_column :nude_reports, :man_vote_count
    remove_column :nude_reports, :woman_vote_count
  end
end
