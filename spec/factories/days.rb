# frozen_string_literal: true

FactoryBot.define do
  factory :day do
    date '2018-10-18'
    successful true
    report 'MyText'
    user
    user_id 1
  end
end
