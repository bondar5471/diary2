# frozen_string_literal: true

module DaysHelper
  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].freeze
  def days_in_month(month, year = Time.now.year)
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end

  def formated_date(date)
    date.strftime('%B %d, %Y')
  end

  def display_day(day_number, days)
    day_detected = days.detect { |d| day_number == d.date.day }
    if day_detected
      color = day_detected.successful ? 'green' : 'red'
      "<a href='/days/#{day_detected['id']}'><div class=\"#{color}\" title='#{formated_date(day_detected.date)} \"#{color}\"'>#{day_detected.date.day}</div></a>".html_safe
    else
      "<a href='/days/new'><div  title='New day'>#{day_number}</div></a>".html_safe
    end
  end
end
