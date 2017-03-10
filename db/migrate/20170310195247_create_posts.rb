class CreatePosts < ActiveRecord::Migration[5.0]
  def up
    add_column :posts, :updated_at, :datetime, after: :created_at, null: false

    execute <<-SQL
      update posts
         set updated_at = created_at
    SQL

    change_column :posts, :category_id, :integer, null: false, after: :id
  end

  def down
    remove_column :posts, :updated_at
  end
end
