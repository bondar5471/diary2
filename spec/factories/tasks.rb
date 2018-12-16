# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    list 'Mytext'
    day
    date_end '2018-10-18'
    duration 'day'
    status 'in_progress'
    user
    user_id 1
  end
end
