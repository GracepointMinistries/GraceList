class DevelopmentMailInterceptor
  def self.delivering_email(msg)
    msg.subject = "#{msg.to} : #{msg.subject}"
    msg.to = Settings.dev_email
  end
end