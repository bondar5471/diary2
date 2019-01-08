# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    list 'MyTask'
    day
    date_end '2019-01-01'
    duration 'day'
    status 'in_progress'
    user
    user_id 1
  end
end
