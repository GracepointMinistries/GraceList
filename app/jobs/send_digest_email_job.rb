class SendDigestEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    if EmailLog.digest_can_send?
      UserMailer.digest_email.deliver_now
    end
  end
end
