module PostsHelper
  # Required asterik
  def required
    raw('<span class="required">*</span>')
  end

  # Return as new item if date is more than 2 days old
  # Arg: d is a Date object
  # Arg: inline_styled is a Boolean for using inline CSS styles
  def mark_as_new(d, inline_styled = false)
    if d > (7.days / Settings.notify_frequency).seconds.ago
      return raw('<span style="font-size: 10px; font-weight: bold; color: #ffffff; background-color: #009900; padding: 1px 3px 1px 3px; margin: 0 0 0 4px;">new</span>') if inline_styled
      return raw('<span class="new">new</span>')
    end
  end

  # Return a formatted post title
  def post_title(p)
    truncate(p.title, length: 50)
  end
end
