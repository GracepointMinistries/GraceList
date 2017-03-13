class AddCategoryActiveness < ActiveRecord::Migration[5.0]
  def change

    change_table :categories do |t|
      t.column :active, :boolean, default: true, null: false, after: :name
      t.timestamps
    end

    execute <<-SQL
      update categories
         set active = 0
       where name = 'Announcements'
    SQL
  end
end
