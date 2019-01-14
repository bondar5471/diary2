# frozen_string_literal: true

# dates = Time.zone.today.beginning_of_year - 1.day
time_create_days = Time.now
Day.delete_all
today = Time.zone.today
dates = (today.beginning_of_year..today.end_of_year).to_a
records = dates.map { |date| Day.new(date: date, user_id: 1) }
ActiveRecord::Base.transaction { records.each(&:save) }
endtime = Time.now - time_create_days
p "Time creating#{endtime}"
p "Created #{Day.count} days"
