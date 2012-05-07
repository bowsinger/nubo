class AddUniqKeyAllModel < ActiveRecord::Migration
  
  def up
    add_column :comments, :uniq_key, :string
    add_column :free_board_comments, :uniq_key, :string
    add_column :free_board_likes, :uniq_key, :string
    add_column :nude_report_likes, :uniq_key, :string
    add_column :nude_reports, :uniq_key, :string
    add_column :votes, :uniq_key, :string
  end

  def down
    remove_column :comments, :uniq_key
    remove_column :free_board_comments, :uniq_key
    remove_column :free_board_likes, :uniq_key
    remove_column :nude_report_likes, :uniq_key
    remove_column :nude_reports, :uniq_key
    remove_column :votes, :uniq_key
  end
end
