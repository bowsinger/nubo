class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :age
      t.string :gender
      t.string :remote_ip
      t.string :answer
      t.integer :nude_report_id

      t.timestamps
    end
  end
end
