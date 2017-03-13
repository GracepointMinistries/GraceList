class EmailLog < ApplicationRecord
  validates :category, :sent_at, presence: true

  # Last digest timestamp
  def self.last_digest_sent
    EmailLog
      .where(category: 'digest')
      .order('sent_at desc')
       .first
      .sent_at
  end

  # Guard digest from being sent within 24 hours of each other
  def self.digest_can_send?
    EmailLog.last_digest_sent < 24.hours.ago && Post.recent_items.count > 0
  end
end
