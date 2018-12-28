dates = Time.zone.today.beginning_of_year - 1.day
Day.destroy_all
Time.zone.today.end_of_year.yday.times do
  Day.create!(
    date: dates += 1.day,
    successful: nil,
    report: nil,
    user_id: nil
  )
end
p "Created #{Day.count} days"
