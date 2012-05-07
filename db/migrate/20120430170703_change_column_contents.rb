class ChangeColumnContents < ActiveRecord::Migration
  def up
    change_column :free_boards, :contents, :text 
  end

  def down
    change_column :free_boards, :contents, :string
  end
end
