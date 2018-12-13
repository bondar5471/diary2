# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    name 'MyString'
    position 1
    list
    list_id 1
    user
  end
end
