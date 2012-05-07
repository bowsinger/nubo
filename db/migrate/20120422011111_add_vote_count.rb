class AddVoteCount < ActiveRecord::Migration
  def up
    add_column :nude_reports, :vote_count, :integer
  end

  def down
    remove_column :nude_reports, :vote_count
  end
end
