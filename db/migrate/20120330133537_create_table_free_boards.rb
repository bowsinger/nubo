class CreateTableFreeBoards < ActiveRecord::Migration
  def up
    drop_table :request_boards
    create_table :free_boards do |t|
      t.integer :age
      t.string :gender
      t.string :remote_ip
      t.string :title
      t.string :contents
      t.integer :category_id
      t.integer :check_count, :default => 0
      t.integer :comment_count, :default => 0
      
      t.timestamps
    end
    add_column :free_boards, :image_file_name, :string
    add_column :free_boards, :image_content_type, :string
    add_column :free_boards, :image_file_size, :integer
    add_column :free_boards, :image_updated_at, :datetime
  end

  def down
    drop_table :free_boards
    create_table :request_boards do |t|
      t.integer :age
      t.string :gender
      t.string :remote_ip
      t.string :title
      t.string :contents
      t.integer :like, :default => 0
      t.integer :category_id
      t.integer :check_count, :default => 0
      t.integer :comment_count, :default => 0
      t.boolean :adopt
      
      t.timestamps
    end
    add_column :request_boards, :image_file_name, :string
    add_column :request_boards, :image_content_type, :string
    add_column :request_boards, :image_file_size, :integer
    add_column :request_boards, :image_updated_at, :datetime
  end
end



