class CreateReportImages < ActiveRecord::Migration
  def change
    create_table :report_images do |t|
      t.integer :position
      t.integer :nude_report_id

      t.timestamps
    end
  end
end
