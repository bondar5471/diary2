# frozen_string_literal: true

class DateValidator < ActiveModel::Validator
  def validate(task)
    task.errors[:base] << 'Date not valid' if task.datebeggin > task.dateend
  end
end
class Task < ApplicationRecord
  belongs_to :day, required: false
  validates_with DateValidator
  validates :list, presence: true
  validates :datebeggin, presence: true
  validates :dateend, presence: true
end
