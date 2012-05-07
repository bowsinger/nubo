class AddColumnCategoryIdNudeReport < ActiveRecord::Migration
  def up
    add_column :nude_reports, :category_id, :integer
  end

  def down
    remove_column :nude_reports, :category_id
  end
  
end
