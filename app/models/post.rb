class Post < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title, :description, :category_id, :author, :email    
  
  def Post.recent_items
    Post.find(:all, :conditions => ['created_at > ?', (7.days/NOTIFY_FREQUENCY).ago]).length
  end
  
end
