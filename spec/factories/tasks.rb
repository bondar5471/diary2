# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    list 'Mytext'
    day ''
  end
  factory :invalid_task, class: 'Task' do
    list nil
  end
end
