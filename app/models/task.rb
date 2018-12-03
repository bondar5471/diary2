# frozen_string_literal: true
class DateValidator < ActiveModel::Validator
  def validate(task)
    if task.datebeggin > task.dateend
      task.errors[:base] << "Date not valid"
    end
  end
end  
class Task < ApplicationRecord
  belongs_to :day, required: false
  validates_with DateValidator
  validates :list, presence: true
  validates :datebeggin, presence: true
  validates :dateend, presence: true
end
