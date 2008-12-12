class AddForSaleCategory < ActiveRecord::Migration
  def self.up
    Category.create(:name => "For Sale")
  end

  def self.down
    Category.find_by_name('For Sale').destroy
  end
end
