class DateTime
  def value
   self
  end

  def date_formatted
    value.strftime("%d/%m/%Y") rescue ' '
  end

  def datetime_formatted
    value.strftime("%d/%m/%Y เมื่อเวลา %H:%M") rescue ' '
  end

  def datetime_for_calender
    value.strftime("%Y-%m-%d %H:%M:%S") rescue ' '
  end

  def datetime_full_format
    I18n.l(value, format: "%d %B %Y %H:%M")
  end

  def datetime_full_format_th
    I18n.l(value, format: "%d %B %Y เวลา %H:%M")
  end

  def datetime_full_format_with_sec_th
    I18n.l(value, format: "%d %B %Y เวลา %H:%M:%S")
  end

  def date_full_format
    I18n.l(value, format: "%d %B %Y")
  end

  def date_format
    I18n.l(value, format: "%d %b %Y")
  end

  def to_day_month
    I18n.l(value, format: "%d %B")
  end

  def to_day_short_month
    I18n.l(value, format: "%d %b")
  end

  def to_day_month_time
    I18n.l(value, format: "%d %B %H:%M")
  end

  def to_time_format
    value.strftime('%H:%M') rescue ' '
  end

  def to_year_month_day
    value.strftime("%Y-%m-%d")
  end

  def last_updated
    value.localtime.to_difference_str
  end
end
