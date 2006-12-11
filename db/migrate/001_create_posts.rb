class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.column "title", :string
      t.column "description", :text
      t.column "author", :string
      t.column "email", :string  
      t.column "created_at", :timestamp
      t.column "category_id", :integer
    end
  end

  def self.down
    drop_table "posts"
  end
end
