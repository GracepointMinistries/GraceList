class Time
  # What time is it in minutes
  def in_minutes
    (self.hour * 60) + self.min
  end

  # Convert minutes to a time today
  # So 1200 minutes = 8:00PM
  def self.minutes_to_time(time_in_minutes)
    Time.parse(Time.at(time_in_minutes.minutes).utc.strftime("%I:%M%p"), Time.current)
  end
end

class Date

  # Day names in column formats.
  def self.day_column_names(format = :full)
    case format
    when :short
      Date::DAYNAMES.map{|n| n.first(3).downcase}
    else
      Date::DAYNAMES.map(&:downcase)
    end
  end

  # Convert a date into a time range.
  # Very useful for SQL date comparison.
  def to_range
    (self.beginning_of_day..self.end_of_day)
  end

  def last_week(day = :monday)
    days_into_week = { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6 }
    result = (self - 7).beginning_of_week + days_into_week[day]
    self.acts_like?(:time) ? result.change(:hour => 0) : result
  end

  def to_yaml( opts={} )
    YAML::quick_emit( self, opts ) do |out|
      out.scalar( "tag:yaml.org,2002:timestamp", self.to_s(:db), :plain )
    end
  end

  # Return the name of the day
  def day_of_week
    days = %w(none monday tuesday wednesday thursday friday saturday sunday)
    return days[self.cwday]
  end

  # Return the abbreviated name of the day
  def abbreviated_day_of_week
    days = %w(none mon tue wed thu fri sat sun)
    return days[self.cwday]
  end


  # Return whether today is a weekday
  def weekday?
    (1..5).include?(self.wday)
  end

  # Return whether today is a weekend
  def weekend?
    self.saturday? || self.sunday?
  end

  # Find the next date for any day
  # Jump to next week if date is in the past.
  # @param date 'Monday', 'Tuesday', 'Wednesday'
  def self.date_of_next(day)
    date  = Date.parse(day)
    if date < Date.current
      date + 1.week
    else
      date
    end
  end

  def self.each_day
    (1..7).each do |day_number|
      week_days = %w(none monday tuesday wednesday thursday friday saturday sunday)
      day_name = week_days[day_number]
      yield day_number, day_name
    end
  end

  def self.parse_date(d, date_format="%m/%d/%Y")
    return d if d.is_a?(Date)

    if d.is_a?(String)
      Date.strptime(d, date_format) rescue nil
    end
  end

  def nice_format(date_format="%m/%d/%Y")
    if self == Date.current
      day_str = 'Today'
    elsif self == Date.current + 1
      day_str = 'Tomorrow'
    end

    if day_str
      return self.strftime("#{day_str} (#{date_format})")
    else
      return self.strftime(date_format)
    end
  end

  def self.pretty_date_distance(from, to)
    days_diff = ((to.beginning_of_day.to_datetime - from.beginning_of_day.to_datetime)).floor
    days_diff_long_form = days_diff.days.from_now.strftime('%-b %-d')
    case days_diff
      when -2
        'day before yesterday'
      when -1
        'yesterday'
      when 0
        'today'
      when 1
        'tomorrow'
      when 2..6
        "this #{days_diff.days.from_now.strftime('%A')}"
      when 7..13
        "next #{to.strftime('%a')} (#{days_diff_long_form})"
      else
        if days_diff > 0
          "in #{days_diff} days (#{days_diff_long_form})"
        else
          "#{days_diff} days ago (#{days_diff_long_form})"
        end
    end
  end
end

class String
  def valid_float?
    # The double negation turns this into an actual boolean true - if you're
    # okay with "truthy" values (like 0.0), you can remove it.
    !!Float(self) rescue false
  end

  def better_titlecase
    self.split(' ').collect{|word| word[0] = word[0..0].upcase; word}.join(' ')
  end

  # Remove https://www. or http://www.
  def strip_url_protocol
    self.sub(/^https?\:\/\//, '').sub(/^http?\:\/\//, '').sub(/^www./,'')
  end

  # Make first character a lowercase
  def uncapitalize
    if self.length > 0
      self[0, 1].downcase + self[1..-1]
    else
      self
    end
  end
end

class Range
  def to_range
    self
  end
end

class Float
  # Pretty formatting of floats
  # 1.0 => 1
  # 2.5 => 2.5
  # 0.10 => 0.1
  def pretty_format
    sprintf('%g', self)
  end
end

class BigDecimal
  # Pretty formatting of BigDecimals
  # 1.0 => 1
  # 2.5 => 2.5
  # 0.10 => 0.1
  def pretty_format
    sprintf('%g', self)
  end
end

module Base64
  Q   = 'Q'.freeze
  EQ  = '='.freeze
  NUL = [0].pack(Q)[0].freeze

  def self.decode_int64(s)
    # Pad with EQ and then pad with NUL to reverse encode_int64
    urlsafe_decode64(s + EQ * ((4 - s.length % 4) % 4)).ljust(8, NUL).unpack(Q).first
  end

  def self.encode_int64(int64)
    p       = [int64].pack(Q)
    # Quickly remove all trailing NUL characters
    p.chomp!(NUL);p.chomp!(NUL);p.chomp!(NUL);p.chomp!(NUL);p.chomp!(NUL);p.chomp!(NUL);p.chomp!(NUL)
    encoded = urlsafe_encode64(p)
    # Quickly remove all trailing EQ characters
    encoded.chomp!(EQ);encoded.chomp!(EQ)
    encoded
  end
end
