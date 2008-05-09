module PostsHelper
  def required
    '<span class="required">*</span>'
  end
  
  # Return as new item if date is more than 2 days old
  # Arg: d is a Date object
  # Arg: inline_styled is a Boolean for using inline CSS styles
  def mark_as_new(d, inline_styled = false)
    if d > (7.days/NOTIFY_FREQUENCY).ago
      return '<span style="font-size: 10px; color: #ffffff; background-color: #cc0000; padding: 1px 3px 1px 3px; margin: 0 0 0 4px;">new</span>' if inline_styled
      return '<span class="new">new</span>'
    end
  end

  # Return a formatted post title
  def post_title(p)
    length = (p.created_at > (7.days/NOTIFY_FREQUENCY).ago) ? 32 : 38
    truncate(p.title, length)
  end
  
  # When is the next time the newsletter will go out
  def next_newsletter_update
    # Round to noontime
    first_update_of_week = Time.now.beginning_of_week + (7.days/NOTIFY_FREQUENCY) + 12.hours
    
    # Figure next update
    multiplier = 1
    while (Time.now > first_update_of_week + multiplier * (7.days/NOTIFY_FREQUENCY))
      multiplier += 1      
    end

    return first_update_of_week + multiplier * (7.days/NOTIFY_FREQUENCY)
  end
  
end