class CreateFreeBoardsLikeAndComments < ActiveRecord::Migration
  def up
    drop_table :likes
    drop_table :request_board_comments
    create_table :free_board_likes do |t|
      t.string :remote_ip
      t.integer :free_board_id

      t.timestamps      
    end
    create_table :free_board_comments do |t|
      t.integer :age
      t.string :gender
      t.string :remote_ip
      t.string :comment
      t.integer :free_board_id
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps      
    end
    
  end

  def down
    drop_table :free_board_likes
    drop_table :free_board_comments
    create_table :likes do |t|
      t.string :remote_ip
      t.integer :request_board_id

      t.timestamps
    end
    create_table :request_board_comments do |t|
      t.integer :age
      t.string :gender
      t.string :remote_ip
      t.string :comment
      t.integer :request_board_id
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end
  
end
