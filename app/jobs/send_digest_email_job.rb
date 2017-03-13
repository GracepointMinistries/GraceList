class SendDigestEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserMailer.digest_email.deliver_now
  end
end
