class CreateLikes < ActiveRecord::Migration
   def up
    create_table :likes do |t|
      t.string :remote_ip
      t.integer :request_board_id

      t.timestamps
    end
    remove_column :request_boards, :like
  end

  def down
    drop_table :likes
    add_column :request_boards, :like, :integer, :default => 0
  end
    
end
