class Notifier < ActionMailer::Base

  def newsletter(body, recent_items, sent_at = Time.now)    
    @subject    = '[GraceList] ' + sent_at.strftime('%A, %m/%d') + ' - ' + recent_items + ' new posts'
    @body       = {"body" => body}
    @recipients = 'chu.conrad@gmail.com'
    @from       = 'gracelist@gpmail.org'
    @sent_on    = sent_at
    @headers    = {}
    @content_type = "text/html"
  end
end
