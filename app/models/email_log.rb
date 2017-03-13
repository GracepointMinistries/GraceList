class EmailLog < ApplicationRecord
  validates :category, :sent_at, presence: true
end
