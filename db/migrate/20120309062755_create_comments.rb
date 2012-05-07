class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :age
      t.string :gender
      t.string :remote_ip
      t.string :comment
      t.integer :nude_report_id

      t.timestamps
    end
  end
end
