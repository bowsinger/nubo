class CreateTableNudeReportLikes < ActiveRecord::Migration
  def up
    create_table :nude_report_likes do |t|
      t.string :remote_ip
      t.integer :nude_report_id

      t.timestamps      
    end
  end

  def down
    drop_table :nude_report_likes
  end
end
