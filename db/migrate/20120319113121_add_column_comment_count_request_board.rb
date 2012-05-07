class AddColumnCommentCountRequestBoard < ActiveRecord::Migration
  def up
    add_column :request_boards, :comment_count, :integer, :default => 0
  end

  def down
    remove_column :request_boards, :comment_count
  end
end