# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
  factory :user do
    email
    password 'B5o4n7d1_'
    password_confirmation 'B5o4n7d1_'
  end
end
