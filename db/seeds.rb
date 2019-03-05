# frozen_string_literal: true

Day.delete_all
today = Time.zone.today
dates = (today.beginning_of_year..today.end_of_year).to_a
time_create_days = Time.zone.now
sql_dates = dates.map { |d| "('#{d}', '1', '#{Time.zone.now}', '#{Time.zone.now}')" }.join(', ')
ActiveRecord::Base.connection.execute("INSERT INTO days (date, user_id, created_at, updated_at) VALUES #{sql_dates}")
endtime = Time.zone.now - time_create_days
p "Time creating #{endtime}"
p "Days count #{Day.count}"
