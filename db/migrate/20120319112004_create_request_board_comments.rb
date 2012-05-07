class CreateRequestBoardComments < ActiveRecord::Migration
  def change
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