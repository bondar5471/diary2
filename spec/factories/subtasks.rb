# frozen_string_literal: true

FactoryBot.define do
  factory :subtask do
    description 'MyString'
    date '2019-01-01'
    resolved false
    task
    user
  end
end
