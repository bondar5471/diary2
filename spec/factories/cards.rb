# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    title 'MyString'
    position 1
    list
    user
  end
end
