# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :day, required: false, touch: true
  belongs_to :user
  validates :list, presence: true
  validates :date_end, presence: true
  validates :duration, presence: true

  enum status: %i[in_progress finished]
  enum duration: %i[day week month year]
end
