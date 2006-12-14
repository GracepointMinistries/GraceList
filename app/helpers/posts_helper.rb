module PostsHelper
  def required
    '<span class="required">*</span>'
  end
  
  # Return as new item if date is more than 2 days old
  # Arg: d is a Date object
  # Arg: inline_styled is a Boolean for using inline CSS styles
  def mark_as_new(d, inline_styled = false)
    if d > NOTIFY_FREQUENCY.days.ago
      return '<span style="font-size: 10px; color: #ffffff; background-color: #cc0000; padding: 1px 3px 1px 3px; margin: 0 0 0 4px;">new</span>' if inline_styled
      return '<span class="new">new</span>'
    end
  end
end
