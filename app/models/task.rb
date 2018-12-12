# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :day, required: false, touch: true
  validates :list, presence: true
  validates :date_begin, presence: true
  validates :date_end, presence: true
  validates :duration, presence: true

  enum status: %i[in_progress status]
  enum duration: %i[year month week day]
end
