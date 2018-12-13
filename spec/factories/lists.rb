# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    name 'MyString'
    position 1
    user
    user_id 1
  end
end
