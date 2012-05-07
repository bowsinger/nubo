class AddAttachmentImageToRequestBoard < ActiveRecord::Migration
  def self.up
    add_column :request_boards, :image_file_name, :string
    add_column :request_boards, :image_content_type, :string
    add_column :request_boards, :image_file_size, :integer
    add_column :request_boards, :image_updated_at, :datetime
  end

  def self.down
    remove_column :request_boards, :image_file_name
    remove_column :request_boards, :image_content_type
    remove_column :request_boards, :image_file_size
    remove_column :request_boards, :image_updated_at
  end
end