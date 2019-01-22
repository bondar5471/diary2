# frozen_string_literal: true

module DaysHelper
  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].freeze
  def days_in_month(month, year = Time.zone.now.year)
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end

  def formated_date(date)
    date.strftime('%A, %B, %d, %Y')
  end

  def display_day(day_number, days)
    detected_day = days.detect { |day| day_number == day.date.day && current_user.creator_of?(day)  }
    if detected_day
      color = detected_day.successful ? 'greentd' : 'redtd'
      colorday = detected_day.successful.nil? ? 'bluetd' : 'greentd'
      "<a href='/days/#{detected_day['id']}'>
      <div class=\"#{color} #{colorday}\" title='#{formated_date(detected_day.date)}'></div>
      </a>".html_safe
    else
      "<a href='/days/new'><div title='New day'></div></a>".html_safe
    end
  end
end
