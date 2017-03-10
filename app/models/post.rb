class Post < ApplicationRecord
  belongs_to :category

  # Validations
  validates :title, :description, :category_id, :author, :email, presence: true

  # Scopes
  scope :in_category, -> (category) { where(category_id: category.id) }
  scope :most_recent, -> { order('created_at desc') }

  # Return number of posts since last notification
  def Post.recent_items
    Post.where('created_at > ?', (7.days/Settings.notify_frequency).ago).count
  end
end
