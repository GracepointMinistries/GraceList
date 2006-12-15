class Post < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title, :description, :category_id, :author, :email    
  
  def Post.recent_items
    num_recent = 0

    posts = Post.find_all
    posts.each do |p|
      num_recent += 1 if p.created_at > (7.days/NOTIFY_FREQUENCY).ago
    end
    
    num_recent
  end
  
end
