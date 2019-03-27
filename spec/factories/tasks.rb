# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    description 'MyTask'
    day
    date_end '2019-01-07'
    duration 'day'
    status 'in_progress'
    user
  end
end
