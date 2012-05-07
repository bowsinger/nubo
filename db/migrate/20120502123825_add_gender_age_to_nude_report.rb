class AddGenderAgeToNudeReport < ActiveRecord::Migration
  def up
    add_column :nude_reports, :age, :integer
    add_column :nude_reports, :gender, :string 
  end

  def down
    remove_column :nude_reports, :age
    remove_column :nude_reports, :gender
  end
end
