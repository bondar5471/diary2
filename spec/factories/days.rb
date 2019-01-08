# frozen_string_literal: true

FactoryBot.define do
  factory :day do
    date '2019-01-01'
    successful true
    report 'MyText'
    user
    user_id 1
  end
end
