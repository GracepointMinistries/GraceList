class Category < ApplicationRecord
  validates :name, presence: true

  has_many :posts

  # Scopes
  scope :active, -> { where(active: true) }
end
