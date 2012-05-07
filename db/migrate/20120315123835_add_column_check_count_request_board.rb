class AddColumnCheckCountRequestBoard < ActiveRecord::Migration
  def up
    add_column :request_boards, :check_count, :integer, :default => 0
  end

  def down
    remove_column :request_boards, :check_count
  end
end
