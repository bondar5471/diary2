# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    list 'Mytext'
    day
    date_begin '2018-10-18'
    date_end '2018-10-18'
    duration 'day'
    status 'in_progress'
  end
end
