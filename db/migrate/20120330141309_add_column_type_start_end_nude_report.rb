class AddColumnTypeStartEndNudeReport < ActiveRecord::Migration
  def up
    add_column :nude_reports, :report_type, :string
    add_column :nude_reports, :start_at, :datetime
    add_column :nude_reports, :end_at, :datetime
  end

  def down
    remove_column :nude_reports, :report_type
    remove_column :nude_reports, :start_at
    remove_column :nude_reports, :end_at
  end
end
