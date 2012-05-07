class AddColumnCheckCountNudeReport < ActiveRecord::Migration
  def up
    add_column :nude_reports, :check_count, :integer, :default => 0
    add_column :nude_reports, :comment_count, :integer, :default => 0
  end

  def down
    remove_column :nude_reports, :comment_count
    remove_column :nude_reports, :check_count
  end
end
