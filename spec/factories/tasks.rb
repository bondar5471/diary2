# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    list 'Mytext'
    day
    datebeggin '2018-10-18'
    dateend '2018-10-18'
    task_type 'day'
    completed 'in_progress'
  end
end
