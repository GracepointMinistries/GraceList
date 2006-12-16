class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table "categories" do |t|
      t.column "name", :string        
    end
    
    Category.create(:name => "Lost")
    Category.create(:name => "Found")    
    Category.create(:name => "Free Stuff")
    Category.create(:name => "Wanted")
    Category.create(:name => "Jobs")
    Category.create(:name => "Announcements")
    
  end

  def self.down
    drop_table "categories"
  end
end
