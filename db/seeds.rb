# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dates = Date.today.beginning_of_year - 1.day
Day.destroy_all
Date.today.end_of_year.yday.times do
  Day.create!(
    date: dates += 1.day,
    successful: nil,
    report: nil
  )
end
p "Created #{Day.count} days"
