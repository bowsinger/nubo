class CreateRequestBoards < ActiveRecord::Migration
  def change
    create_table :request_boards do |t|
      t.integer :age
      t.string :gender
      t.string :remote_ip
      t.string :title
      t.string :contents
      t.integer :like, :default => 0
      t.integer :category_id
      t.boolean :adopt
      

      t.timestamps
    end
  end
end
