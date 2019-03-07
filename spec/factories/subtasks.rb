# frozen_string_literal: true

FactoryBot.define do
  factory :subtask do
    description 'MyString'
    resolved false
    task_id
    user
  end
end
