class CreateNudeReports < ActiveRecord::Migration
  def change
    create_table :nude_reports do |t|
      t.string :title
      t.string :a
      t.string :b
      t.string :c
      t.string :d

      t.timestamps
    end
  end
end
