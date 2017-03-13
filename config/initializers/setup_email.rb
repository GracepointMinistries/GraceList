# Set up connection to Mailer
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:        Settings.mailer.address,
  port:           Settings.mailer.port,
  domain:         Settings.mailer.domain,
  authentication: :plain,
  user_name:      Settings.mailer.user_name,
  password:       Settings.mailer.password
}

# Intercept all email in development
require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) unless Rails.env.production?
