# frozen_string_literal: true

FactoryBot.define do
  factory :day do
    date '2019-01-01'
    successful true
    report 'MyText'
    user
  end
end
