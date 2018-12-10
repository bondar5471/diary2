# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :day, required: false, touch: true
  validates :list, presence: true
  validates :date_begin, presence: true
  validates :date_end, presence: true
  validates :task_type, presence: true

  enum completed: %i[in_progress completed]
  enum task_type: %i[year month week day]
end
