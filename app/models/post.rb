class Post < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title, :description, :category_id, :author, :email    
end
